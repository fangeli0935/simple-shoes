ALTER TABLE Cliente ADD Situacao bit NOT NULL CONSTRAINT [DF_Cliente_Situacao] DEFAULT 1 
GO

UPDATE Cliente
  SET Situacao = 0
WHERE Codigo in (2,5,8)
GO