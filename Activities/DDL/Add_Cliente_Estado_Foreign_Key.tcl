
ALTER TABLE [dbo].[Cliente] 
  ADD CONSTRAINT [FK_Cliente_CodEstadoNascimento_Estado_Codigo] FOREIGN KEY([CodEstadoNascimento]) REFERENCES [dbo].[Estado] ([Codigo])
GO

ALTER TABLE [dbo].[Cliente] 
  ADD CONSTRAINT [FK_Cliente_CodEstadoResidencia_Estado_Codigo] FOREIGN KEY([CodEstadoResidencia]) REFERENCES [dbo].[Estado] ([Codigo])
GO