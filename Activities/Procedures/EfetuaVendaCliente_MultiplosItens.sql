
-- ----------------------------------------------------
-- Venda com multiplos itens


CREATE OR ALTER PROCEDURE EfetuaVendaCliente(
     @Cliente    tinyint
   , @Itens      TT_VendaItem READONLY
)
AS
BEGIN
   PRINT '-------------------------'

   SET NOCOUNT ON

   DECLARE @MSG nvarchar(max)
   
   PRINT 'Validando cliente ...'

   /* Valida se cliente existe no cadastro */
   IF NOT EXISTS (SELECT TOP 1 1 
                    FROM Cliente
			       WHERE Codigo = @Cliente)
   BEGIN
      SET @MSG = '!!! ERRO - Cliente não encontrado !!!'
	  RAISERROR(@MSG, 16, 1) 
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
      SET @MSG = '!!! ERRO - Cliente não está com cadastro ativo !!!'
	  RAISERROR(@MSG, 16, 1) 
   END
   
   PRINT 'Validando Produto ...'

   /* Valida se o produto existe no cadastro */
   IF EXISTS (SELECT TOP 1 1
                     FROM @Itens i
				LEFT JOIN Produto p ON p.Codigo = i.CodProduto
					WHERE p.Codigo IS NULL)
   BEGIN
      DECLARE @Produto varchar(256)
	  DECLARE @CodProduto tinyint
	  DECLARE C_Produto CURSOR READ_ONLY FOR
	        SELECT i.CodProduto
              FROM @Itens i
         LEFT JOIN Produto p ON p.Codigo = i.CodProduto
             WHERE p.Codigo IS NULL;

      OPEN C_Produto;
	  FETCH NEXT FROM C_Produto INTO @CodProduto

	  WHILE (@@FETCH_STATUS = 0)
	  BEGIN
	     SET @Produto = CONCAT(@Produto, @CodProduto, ', ')
	     FETCH NEXT FROM C_Produto INTO @CodProduto
	  END

	  CLOSE C_Produto;
	  DEALLOCATE C_Produto;

      SET @MSG = CONCAT('!!! ERRO - Produto(s)s não cadastrados: ', @Produto, ' !!!')
	  RAISERROR(@MSG, 16, 1) 

   END   
   
   /* Se passou pelas validacoes processa a venda */
   BEGIN
      PRINT 'Processando venda ...'

      DECLARE @CodVenda tinyint;
	  DECLARE @NomeProduto varchar(256);
	  DECLARE @PrecoUnit numeric(10,2);
	  
	  PRINT 'Gravando venda ...'

      BEGIN TRY
      INSERT INTO Venda ( CodCliente
                        , DataVenda)
                 VALUES ( @Cliente
						, GETDATE()
                        )

      SELECT @CodVenda = @@IDENTITY


	  PRINT 'Gravando itens da venda ...'

      INSERT INTO VendaItem
	                    ( CodVenda
						, CodProduto
						, NomeProduto
						, ValorUnit
						, QuantVenda
	                    )
                   SELECT @CodVenda
				        , i.CodProduto
					    , p.Nome
					    , p.PrecoUnidade
					    , i.QuantVenda
                     FROM @Itens i
				     JOIN Produto p ON p.Codigo = i.CodProduto

      
	   PRINT 'Venda concluída com sucesso.'
	   END TRY
	   BEGIN CATCH
	      SET @MSG = CONCAT('!!! ERRO ', ERROR_LINE(), ' - ', ERROR_MESSAGE(), '!!!')
		  RAISERROR(@MSG, 16, 1) 
	   END CATCH
   END

   PRINT '-------------------------'
END
GO


DECLARE @ItensVenda TT_VendaItem;
DECLARE @Cliente tinyint;

--INSERT INTO @ItensVenda 
--   VALUES (1, 10),
--          (2, 5),
--		  (3, 7),
--		  (133,10),
--		  (200, 7);

INSERT INTO @ItensVenda 
   VALUES (1, 1440),
          (3, 5),
		  (5, 7);

EXEC dbo.EfetuaVendaCliente @Cliente = 1, @Itens = @ItensVenda;
GO

--SELECT * FROM Venda ORDER BY Codigo DESC
--SELECT * FROM VendaItem ORDER BY CodVenda DESC



