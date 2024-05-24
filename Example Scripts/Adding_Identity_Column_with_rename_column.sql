
-- ---------------------------------------------------------
-- Adicionar identity na tabela de Produto

-- A tabela possui FK na coluna, então antes é preciso remover a constraint
ALTER TABLE VendaItem DROP CONSTRAINT FK_VendaItem_CodProduto_Produto_Codigo
GO

-- Em seguida, removemos a chave primária
ALTER TABLE Produto DROP CONSTRAINT PK_Produto_Codigo
GO

-- Vamos manter a coluna antiga com o codigo caso seja necessario algum ajuste
EXEC sp_rename 'dbo.Produto.Codigo', 'Codigo_old', 'COLUMN'
GO

-- A nova coluna agora com auto-numeração é incluída
ALTER TABLE Produto ADD Codigo tinyint IDENTITY(1,1)
GO

-- Se não precisamos mais da coluna antiga, pode ser feito o DROP  
-- ALTER TABLE Produto DROP COLUMN Codigo_old
-- GO

-- Restauramos a chave primária
ALTER TABLE Produto ADD CONSTRAINT [PK_Produto_Codigo] PRIMARY KEY (Codigo);
GO

-- E então restauramos a chave estrangeira
ALTER TABLE [dbo].[VendaItem] ADD CONSTRAINT [FK_VendaItem_CodProduto_Produto_Codigo] FOREIGN KEY([CodProduto]) REFERENCES [dbo].[Produto] ([Codigo])
GO

