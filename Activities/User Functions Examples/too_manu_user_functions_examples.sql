
-- ---------------------------------------------------------
-- -- Funções
 
SELECT ProductId
     , Weight1 = ISNULL(Weight, 50)
	 , Weight
FROM Production.Product;  
GO  

SELECT CONCAT ('Happy ', 'Birthday ', 11, '/', '25') AS Result;

DECLARE @a INT = 45, @b INT = 40;
SELECT [Result] = IIF( @a > @b, 'TRUE', 'FALSE' );
GO


CREATE OR ALTER FUNCTION SomaDoisNumeros (
     @Numero1 int
   , @Numero2 int
   ) RETURNS int
AS
BEGIN
   RETURN @Numero1 + @Numero2
END;
GO

SELECT Resultado = dbo.SomaDoisNumeros(1,2)
GO

CREATE OR ALTER FUNCTION fn_SituacaoUsuario(
     @CodigoSituacao tinyint
	 ) RETURNS varchar(20)
AS
BEGIN
   RETURN CASE @CodigoSituacao
            WHEN 1 THEN 'Liberado'
			WHEN 2 THEN 'Bloqueado'
			ELSE 'Desconhecido'
		  END
END;
GO

SELECT dbo.fn_SituacaoUsuario(1), dbo.fn_SituacaoUsuario(2), dbo.fn_SituacaoUsuario(3)
GO

CREATE FUNCTION AdicionaMinutos(
   @Minutos int,
   @Data    datetime
   ) RETURNS datetime
AS
BEGIN
   RETURN DATEADD(MINUTE, @Minutos, @Data)
END
GO

SELECT [DataHora Atual]   = GETDATE()
     , [DataHora + 15min] = dbo.AdicionaMinutos(15, GETDATE())
GO


CREATE OR ALTER FUNCTION CpfSoNumero(
   @Cpf varchar(14)
) RETURNS varchar(14)
AS
BEGIN
   RETURN REPLACE(REPLACE(@Cpf, '.',''),'-','')
END
GO

CREATE OR ALTER FUNCTION ObterNomeCidade(
   @Codigo tinyint
) RETURNS varchar(256)
AS
BEGIN
   DECLARE @Nome varchar(256)

   SELECT @Nome = Nome
     FROM Cidade
    WHERE Codigo = @Codigo

   RETURN @Nome
END
GO

CREATE OR ALTER FUNCTION ObterNomeUF(
   @Codigo tinyint
) RETURNS varchar(256)
AS
BEGIN
   DECLARE @Nome varchar(256)

   SELECT @Nome = Nome
     FROM Estado
    WHERE Codigo = @Codigo

   RETURN @Nome
END
GO

CREATE OR ALTER FUNCTION FormataCep(
   @Cep int
) RETURNS varchar(10)
AS 
BEGIN
 RETURN CONCAT(SUBSTRING(CONVERT(VARCHAR, @Cep),1,2),'.',SUBSTRING(CONVERT(VARCHAR, @Cep),3,4), '-', SUBSTRING(CONVERT(VARCHAR, @Cep),7,8))
END
GO
