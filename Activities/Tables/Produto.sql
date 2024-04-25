
CREATE TABLE Produto(
   Codigo       tinyint       NOT NULL
 , Nome         varchar(256)  NOT NULL
 , PrecoUnidade	numeric(10,2) NOT NULL
 );
 GO

 ALTER TABLE Produto ADD CONSTRAINT [PK_Produto_Codigo] PRIMARY KEY (Codigo);
 GO

 INSERT INTO Produto (Codigo, Nome, PrecoUnidade)
   VALUES (1, 'Tinta transparente para alvenaria', 19.99),
          (2, 'Pincel sem ponta', 28.89),
          (3, 'Caneta Azul de duas cores', 37.79),
          (4, 'Lápis de grafite 0.7', 46.69),
          (5, 'Balde de plástico furado', 55.59),
          (6, 'Escada retrátil de madeira', 64.49),
          (7, 'Espelho sem aço', 73.39),
          (8, 'Broca de madeira 9mm', 82.29),
          (9, 'Lenço de papel úmido', 90.19),
          (10,'Saco de batatas sem fundo', 22.75);
GO
