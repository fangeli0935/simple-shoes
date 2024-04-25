
CREATE TABLE Cidade(
     Codigo tinyint NOT NULL
   , Nome   varchar(256) NOT NULL
);
GO

INSERT INTO Cidade 
  VALUES (1, 'Brusque'),
         (2, 'Blumenau'),
		 (3, 'Guabiruba'),
		 (4, 'Gaspar'),
		 (5, 'Ilhota'),
		 (8, 'Timbó'),
		 (9, 'Tijucas'),
		 (10, 'Florinaópolis');
GO
