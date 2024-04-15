-- https://learn.microsoft.com/en-us/sql/relational-databases/tables/specify-default-values-for-columns?view=sql-server-ver16

CREATE TABLE dbo.doc_exz (column_a INT, column_b INT); -- Allows nulls.
GO
INSERT INTO dbo.doc_exz (column_a) VALUES (7);
GO
ALTER TABLE dbo.doc_exz
  ADD CONSTRAINT DF_Doc_Exz_Column_B
  DEFAULT 50 FOR column_b;
GO