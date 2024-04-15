-- https://learn.microsoft.com/en-us/sql/relational-databases/tables/create-primary-keys?view=sql-server-ver16

CREATE TABLE Production.TransactionHistoryArchive1
   (
      TransactionID int IDENTITY (1,1) NOT NULL
      , CONSTRAINT PK_TransactionHistoryArchive1_TransactionID PRIMARY KEY CLUSTERED (TransactionID)
   )
;