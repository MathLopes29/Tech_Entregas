CREATE TABLE Veiculo (
  idPlacaVeiculo VARCHAR(7)   NOT NULL ,
  Ano INTEGER(4)    ,
  Modelo VARCHAR(12)    ,
  Cor VARCHAR      ,
PRIMARY KEY(idPlacaVeiculo));




CREATE TABLE Empresas (
  idCNPJ INTEGER(14)   NOT NULL ,
  Nome_Com VARCHAR(30)    ,
  Telefone_Com INTEGER(15)    ,
  Email_Com VARCHAR(40)    ,
  Ender_Com VARCHAR(50)      ,
PRIMARY KEY(idCNPJ));




CREATE TABLE Produtos (
  idProdutos INTEGER   NOT NULL ,
  Empresas_idCNPJ INTEGER(14)   NOT NULL ,
  Nome_Prod VARCHAR(50)    ,
  Marca_Prod VARCHAR(50)    ,
  Peso_Prod INTEGER(10)    ,
  Valor_Unitario FLOAT(10)      ,
PRIMARY KEY(idProdutos)  ,
  FOREIGN KEY(Empresas_idCNPJ)
    REFERENCES Empresas(idCNPJ));


CREATE INDEX Produtos_FKIndex1 ON Produtos (Empresas_idCNPJ);


CREATE INDEX IFK_Tem ON Produtos (Empresas_idCNPJ);


CREATE TABLE Cliente (
  idCPF INTEGER(11)   NOT NULL ,
  Empresas_idCNPJ INTEGER(14)   NOT NULL ,
  Nome VARCHAR(50)    ,
  Email VARCHAR(40)    ,
  Ender VARCHAR(50)    ,
  Telefone INTEGER(15)    ,
  CEP INTEGER(7)      ,
PRIMARY KEY(idCPF)  ,
  FOREIGN KEY(Empresas_idCNPJ)
    REFERENCES Empresas(idCNPJ));


CREATE INDEX Cliente_FKIndex1 ON Cliente (Empresas_idCNPJ);


CREATE INDEX IFK_Tem ON Cliente (Empresas_idCNPJ);


CREATE TABLE Pedido (
  idNumPedido INTEGER   NOT NULL ,
  Cliente_idCPF INTEGER(11)   NOT NULL ,
  Data_Postagem DATETIME    ,
  Ender_Final VARCHAR(50)    ,
  Destinatario VARCHAR(50)      ,
PRIMARY KEY(idNumPedido)  ,
  FOREIGN KEY(Cliente_idCPF)
    REFERENCES Cliente(idCPF));


CREATE INDEX Pedido_FKIndex1 ON Pedido (Cliente_idCPF);


CREATE INDEX IFK_Faz ON Pedido (Cliente_idCPF);


CREATE TABLE Entrega (
  Veiculo_idPlacaVeiculo VARCHAR(7)   NOT NULL ,
  Pedido_idNumPedido INTEGER   NOT NULL ,
  Stats_Prod VARCHAR(20)    ,
  Localização_Atual VARCHAR(40)    ,
  Data_Entrega DATE    ,
  Frete FLOAT      ,
PRIMARY KEY(Veiculo_idPlacaVeiculo, Pedido_idNumPedido)    ,
  FOREIGN KEY(Pedido_idNumPedido)
    REFERENCES Pedido(idNumPedido),
  FOREIGN KEY(Veiculo_idPlacaVeiculo)
    REFERENCES Veiculo(idPlacaVeiculo));


CREATE INDEX Pedido_has_Veiculo_FKIndex1 ON Entrega (Pedido_idNumPedido);
CREATE INDEX Pedido_has_Veiculo_FKIndex2 ON Entrega (Veiculo_idPlacaVeiculo);


CREATE INDEX IFK_Gera ON Entrega (Pedido_idNumPedido);
CREATE INDEX IFK_Usa ON Entrega (Veiculo_idPlacaVeiculo);


CREATE TABLE Itens_Produto (
  Produtos_idProdutos INTEGER   NOT NULL ,
  Pedido_idNumPedido INTEGER   NOT NULL ,
  Quantidade FLOAT    ,
  Valor_Total FLOAT      ,
PRIMARY KEY(Produtos_idProdutos, Pedido_idNumPedido)    ,
  FOREIGN KEY(Produtos_idProdutos)
    REFERENCES Produtos(idProdutos),
  FOREIGN KEY(Pedido_idNumPedido)
    REFERENCES Pedido(idNumPedido));


CREATE INDEX Produtos_has_Pedido_FKIndex1 ON Itens_Produto (Produtos_idProdutos);
CREATE INDEX Produtos_has_Pedido_FKIndex2 ON Itens_Produto (Pedido_idNumPedido);


CREATE INDEX IFK_Vendidos ON Itens_Produto (Produtos_idProdutos);
CREATE INDEX IFK_Resultam ON Itens_Produto (Pedido_idNumPedido);



