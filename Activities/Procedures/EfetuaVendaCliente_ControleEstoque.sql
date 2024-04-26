

CREATE OR ALTER PROCEDURE EfetuaVendaCliente(
     @Cliente    tinyint
   , @Itens      TT_VendaItem READONLY
)
AS
BEGIN
   SET NOCOUNT ON;

   DECLARE @MSG NVARCHAR(MAX)

   BEGIN TRY
   /* Valida se cliente existe no cadastro */
   IF NOT EXISTS (SELECT TOP 1 1 
                    FROM Cliente
			       WHERE Codigo = @Cliente)
   BEGIN
      SET @MSG = '!!! ERRO - Cliente não encontrado !!!'
	  RAISERROR(@MSG, 16, 1) -- Caso o cliente nao exista aborta a procedure
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
	  RAISERROR(@MSG, 16, 1) -- Caso o cliente nao esteja com cadastro ativo aborta a procedure
   END
   /* Valida se o produto existe no cadastro */
   ELSE IF EXISTS (SELECT TOP 1 1
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
	  RAISERROR(@MSG, 16, 1) -- Caso algum produto nao esteja cadastrado aborta a procedure
   END
   /* Se passou pelas validacoes processa a venda */
   ELSE
   BEGIN
      DECLARE @EstoqueAtualizado bit = 0
      DECLARE @Quantidade int
      DECLARE C_Estoque CURSOR 
	    FOR 
		 SELECT CodProduto
		      , QuantVenda
		   FROM @Itens

	   OPEN C_Estoque
	   FETCH NEXT FROM C_Estoque INTO @CodProduto, @Quantidade

	   WHILE @@FETCH_STATUS = 0
	   BEGIN
	     IF  ((SELECT dbo.ObterEstoqueProduto(@CodProduto)) = 0)
		 BEGIN
		    SET @MSG = CONCAT('!!! ERRO - O produto ', @CodProduto, ' não possui estoque disponível!')
			RAISERROR(@MSG, 16, 1) -- Caso algum produto não tenha estoque aborta a procedure
		 END

	      IF ((SELECT dbo.ObterEstoqueProduto(@CodProduto) + (@Quantidade * -1)) < 0)
		  BEGIN
		     SET @MSG = CONCAT('!!! ERRO - O produto ', @CodProduto, ' ficará com estoque negativo!')
			 RAISERROR(@MSG, 16, 1) -- Caso algum produto fique com estoque negativo aborta a procedure
		  END

		  FETCH NEXT FROM C_Estoque INTO @CodProduto, @Quantidade
       END

	   CLOSE C_Estoque

	   -- Atualiza o estoque
	   OPEN C_Estoque
	   FETCH NEXT FROM C_Estoque INTO @CodProduto, @Quantidade

	   WHILE @@FETCH_STATUS = 0
	   BEGIN
	      UPDATE e
		     SET e.Quantidade = e.Quantidade + (@Quantidade * -1)
		    FROM Estoque e
		   WHERE e.CodProduto = @CodProduto

		  FETCH NEXT FROM C_Estoque INTO @CodProduto, @Quantidade
       END
	   CLOSE C_Estoque

	   DEALLOCATE C_Estoque

	   DECLARE @UltimaVenda tinyint

	   -- Insere a venda
	   INSERT INTO Venda (CodCliente) VALUES (@Cliente)

	   -- Obtem Id da Venda
	   SELECT @UltimaVenda = @@IDENTITY
	   
	   -- Insere os itens da venda
	   INSERT INTO VendaItem (CodVenda, CodProduto, NomeProduto, ValorUnit, QuantVenda)
	     SELECT @UltimaVenda
		      , i.CodProduto
			  , p.Nome
			  , p.PrecoUnidade
			  , i.QuantVenda
           FROM @Itens i
		   JOIN Produto p on p.Codigo = i.CodProduto
      END
   END TRY
   BEGIN CATCH
      PRINT ERROR_MESSAGE()
   END CATCH
END
GO

SET NOCOUNT ON

DECLARE @ItensVenda TT_VendaItem;
DECLARE @Cliente tinyint;

--INSERT INTO @ItensVenda 
--   VALUES (1, 10),
--          (2, 5),
--		  (3, 7),
--		  (133,10),
--		  (200, 7);

INSERT INTO @ItensVenda 
   VALUES (2, 1),
          (3, 1),
		  (5, 1),
		  (11,1);

EXEC dbo.EfetuaVendaCliente @Cliente = 1, @Itens = @ItensVenda;
GO

-- select * from Estoque




