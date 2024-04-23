CREATE TABLE Cliente (
     Codigo             tinyint      NOT NULL
   , Nome               varchar(256) NOT NULL
   , DataNascimento     date         NOT NULL
   , Cpf                varchar(14)  NOT NULL
   , CidadeNascimento   varchar(256) NOT NULL
   , EstadoNascimento   char(2)      NOT NULL
   , CidadeResidencia   varchar(256) NOT NULL
   , EstadoResidencia   char(2)      NOT NULL
   , EndLogradouro      varchar(256) NOT NULL
   , EndNumero          smallint     NOT NULL
   , Cep                int          NOT NULL 
);
GO