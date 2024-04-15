-- https://learn.microsoft.com/pt-br/sql/t-sql/statements/create-index-transact-sql?view=sql-server-ver16


-- UK
CREATE UNIQUE INDEX AK_UnitMeasure_Name
  ON Production.UnitMeasure(Name);


-- IX com include de colunas
CREATE NONCLUSTERED INDEX IX_Address_PostalCode
  ON Person.Address (PostalCode)
  INCLUDE (AddressLine1, AddressLine2, City, StateProvinceID);
GO

SELECT AddressLine1, AddressLine2, City, StateProvinceID, PostalCode
FROM Person.Address
WHERE PostalCode BETWEEN N'98000' and N'99999';
GO

-- IX filtrado
CREATE NONCLUSTERED INDEX "FIBillOfMaterialsWithEndDate"
  ON Production.BillOfMaterials (ComponentID, StartDate)
  WHERE EndDate IS NOT NULL;