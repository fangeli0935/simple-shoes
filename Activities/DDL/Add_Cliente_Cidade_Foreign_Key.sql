
ALTER TABLE [dbo].[Cliente] 
  ADD CONSTRAINT [FK_Cliente_CodCidadeNascimento_Cidade_Codigo] FOREIGN KEY([CodCidadeNascimento]) REFERENCES [dbo].[Cidade] ([Codigo])
GO


ALTER TABLE [dbo].[Cliente] 
  ADD CONSTRAINT [FK_Cliente_CodCidadeResidencia_Cidade_Codigo] FOREIGN KEY([CodCidadeResidencia]) REFERENCES [dbo].[Cidade] ([Codigo])
GO