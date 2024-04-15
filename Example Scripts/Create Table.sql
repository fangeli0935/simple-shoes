-- https://learn.microsoft.com/en-us/sql/t-sql/statements/create-table-transact-sql?view=sql-server-ver16

CREATE TABLE dbo.PurchaseOrderDetail (
    PurchaseOrderID INT NOT NULL,
    LineNumber SMALLINT NOT NULL,
    ProductID INT NULL,
    UnitPrice MONEY NULL,
    OrderQty SMALLINT NULL,
    ReceivedQty FLOAT NULL,
    RejectedQty FLOAT NULL,
    DueDate DATETIME NULL
);