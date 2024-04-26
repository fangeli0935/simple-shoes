
-- Procedura da ATV022

CREATE OR ALTER PROCEDURE EfetuaVendaCliente(
     @Cliente    tinyint
   , @Produto    tinyint
   , @Quantidade tinyint
)
AS
BEGIN
   /* Valida se cliente existe no cadastro */
   IF NOT EXISTS (SELECT TOP 1 1 
                    FROM Cliente
			       WHERE Codigo = @Cliente)
   BEGIN
      SELECT Mensagem = '!!! ERRO - Cliente não encontrado !!!'
   END
   /* Valida se o cliente esta com situacao ativo */
   ELSE IF NOT EXISTS (SELECT TOP 1 1 
                         FROM Cliente c
						WHERE c.Codigo = @Cliente
						  AND EXISTS (SELECT TOP 1 1
						                FROM SituacaoCliente sc
									   WHERE sc.Nome   = 'Ativo'
									     AND sc.Codigo = c.Situacao)
									  )
   BEGIN
      SELECT Mensagem =  '!!! ERRO - Cliente não está com cadastro ativo !!!'
   END
   /* Valida se o produto existe no cadastro */
   ELSE IF NOT EXISTS (SELECT TOP 1 1
                         FROM Produto p
						WHERE p.Codigo = @Produto)
   BEGIN
      SELECT Mensagem =  '!!! ERRO - Produto não cadastrado !!!'
   END
   /* Se passou pelas validacoes processa a venda */
   ELSE
   BEGIN
      DECLARE @UltimaVenda tinyint;
	  DECLARE @NomeProduto varchar(256);
	  DECLARE @PrecoUnit numeric(10,2);
	  

	  SELECT @UltimaVenda = MAX(Codigo)+1 
	    FROM Venda

	  SELECT @NomeProduto = p.Nome
	       , @PrecoUnit   = p.PrecoUnidade
	    FROM Produto p 
       WHERE p.Codigo = @Produto

      BEGIN TRY
      INSERT INTO Venda ( Codigo
                        , CodProduto
                        , NomeProduto
                        , ValorUnit
                        , QuantVenda
                        , CodCliente
                        , DataVenda)
                 VALUES ( @UltimaVenda
                        , @Produto
              	        , @NomeProduto
              	        , @PrecoUnit
              	        , @Quantidade
              	        , @Cliente
						, GETDATE()
                        )
      
	   SELECT Mensagem = 'Venda concluída com sucesso'
	   END TRY
	   BEGIN CATCH
	      SELECT CONCAT('!!! ERRO ', ERROR_LINE(), ' - ', ERROR_MESSAGE(), '!!!')
	   END CATCH
   END
END
GO


DECLARE @Cliente tinyint, @Produto tinyint, @Quantidade tinyint;
EXEC dbo.EfetuaVendaCliente @Cliente = 1, @Produto = 1, @Quantidade = 10
GO
