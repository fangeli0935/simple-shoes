-- Exemplo de view limitando acesso por role do banco
CREATE OR ALTER VIEW vClienteAtivo AS
SELECT c.Codigo
     , c.Nome
	   , c.DataNascimento
	   , c.Cpf
  FROM Cliente c
 WHERE c.Situacao = 1
   AND IS_MEMBER('db_datareader') = 1 --Somente irá retornar dados se o usuário possuir a role db_datareader
GO
