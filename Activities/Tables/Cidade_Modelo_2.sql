CREATE TABLE Cliente (
     Codigo              tinyint      NOT NULL
   , Nome                varchar(256) NOT NULL
   , DataNascimento      date         NOT NULL
   , Cpf                 varchar(14)  NOT NULL
   , CodCidadeNascimento tinyint      NOT NULL
   , CodEstadoNascimento tinyint      NOT NULL
   , CodCidadeResidencia tinyint      NOT NULL
   , CodEstadoResidencia tinyint      NOT NULL
   , EndLogradouro       varchar(256) NOT NULL
   , EndNumero           smallint     NOT NULL
   , Cep                 int          NOT NULL 
);
GO

INSERT INTO Cliente (Codigo,Nome,DataNascimento,Cpf,CodCidadeNascimento,CodEstadoNascimento,CodCidadeResidencia,CodEstadoResidencia,EndLogradouro,EndNumero,Cep)
 VALUES (1, 'Genoveva Armindo da Silva'   , '1970-01-01', '109.135.618-90', 1,1,1,1,'Rua numero zero'  , 10, 10045678),
        (2, 'João Cesar Augusto'          , '1990-04-07', '217.230.272-98', 1,1,1,1,'Rua numero um'    , 20, 13445679),
		(3, 'Joana Almeida Santos'        , '1950-08-04', '325.339.374-70', 1,1,1,1,'Rua numero dois'  , 30, 12455973),
		(4, 'Cleiton de Souza Prado'      , '2005-01-23', '434.438.473-96', 1,1,1,1,'Rua numero tres'  , 40, 12356648),
		(5, 'Esmeraldina Silva e Lima'    , '1980-04-22', '543.537.528-50', 1,1,1,1,'Rua numero quatro', 50, 12746578),
		(6, 'Augusto Pena'                , '1979-09-17', '652.636.674-94', 1,1,1,1,'Rua numero cinco' , 60, 12646788),
		(7, 'Leopoldina de Bragança'      , '2006-05-11', '765.734.718-30', 1,1,1,1,'Rua numero seis'  , 70, 12375689),
		(8, 'Cristóvan Buarque de Orleans', '1976-02-20', '871.835.874-92', 1,1,1,1,'Rua numero sete'  , 80, 12835679),
		(9, 'Barbara Souto Coelho Campo'  , '2001-03-31', '985.425.978-10', 1,1,1,1,'Rua numero oito'  , 90, 19325678);
GO
