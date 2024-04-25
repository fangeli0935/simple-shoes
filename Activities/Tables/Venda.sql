
CREATE TABLE Venda(
   Codigo      tinyint       NOT NULL
 , CodProduto  tinyint       NOT NULL
 , NomeProduto varchar(256)  NOT NULL
 , ValorUnit   numeric(10,2) NOT NULL
 , QuantVenda  int           NOT NULL
 , CodCliente  tinyint       NOT NULL
);
GO

ALTER TABLE Venda ADD CONSTRAINT [PK_Venda_Codigo] PRIMARY KEY (Codigo);
GO

ALTER TABLE [dbo].[Venda] ADD CONSTRAINT [FK_Venda_CodProduto_Produto_Codigo] FOREIGN KEY([CodProduto]) REFERENCES [dbo].[Produto] ([Codigo])
GO

ALTER TABLE [dbo].[Venda] ADD CONSTRAINT [FK_Venda_CodCliente_Cliente_Codigo] FOREIGN KEY([CodCliente]) REFERENCES [dbo].[Cliente] ([Codigo])
GO

CREATE INDEX IX_Venda_CodProduto ON [Venda](CodProduto)
GO

CREATE INDEX IX_Venda_CodCliente ON [Venda](CodCliente)
GO

INSERT INTO Venda 
  VALUES (1,  1, (SELECT Nome FROM Produto WHERE Codigo = 1), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 1),  1,9),
         (2,  2, (SELECT Nome FROM Produto WHERE Codigo = 2), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 2),  3,8),
         (3,  3, (SELECT Nome FROM Produto WHERE Codigo = 3), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 3),  1,7),
         (4,  4, (SELECT Nome FROM Produto WHERE Codigo = 4), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 4),  2,6),
         (5,  5, (SELECT Nome FROM Produto WHERE Codigo = 5), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 5),  9,5),
         (6,  6, (SELECT Nome FROM Produto WHERE Codigo = 6), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 6),  1,4),
         (7,  7, (SELECT Nome FROM Produto WHERE Codigo = 7), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 7),  2,3),
         (8,  8, (SELECT Nome FROM Produto WHERE Codigo = 8), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 8),  6,2),
         (9,  9, (SELECT Nome FROM Produto WHERE Codigo = 9), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 9),  4,1),
		 (10,  1, (SELECT Nome FROM Produto WHERE Codigo = 1), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 1), 3,1),
         (11,  2, (SELECT Nome FROM Produto WHERE Codigo = 2), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 2), 8,2),
         (12,  3, (SELECT Nome FROM Produto WHERE Codigo = 3), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 3), 3,3),
         (13,  4, (SELECT Nome FROM Produto WHERE Codigo = 4), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 4), 8,4),
         (14,  5, (SELECT Nome FROM Produto WHERE Codigo = 5), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 5), 6,5),
         (15,  6, (SELECT Nome FROM Produto WHERE Codigo = 6), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 6), 4,4),
         (16,  7, (SELECT Nome FROM Produto WHERE Codigo = 7), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 7), 9,3),
         (17,  8, (SELECT Nome FROM Produto WHERE Codigo = 8), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 8), 7,2),
         (18,  9, (SELECT Nome FROM Produto WHERE Codigo = 9), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 9), 1,1),
		 (19,  9, (SELECT Nome FROM Produto WHERE Codigo = 9), (SELECT PrecoUnidade FROM Produto WHERE Codigo = 9), 7,1);
GO
