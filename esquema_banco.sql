CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY AUTO_INCREMENT,  
    Nome VARCHAR(100) NOT NULL,               
    Email VARCHAR(100) UNIQUE NOT NULL,       
    Telefone VARCHAR(20),                    
    Endereco VARCHAR(255),                    
    DataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP 
);
CREATE TABLE Produtos (
    ProdutoID INT PRIMARY KEY AUTO_INCREMENT, 
    Nome VARCHAR(100) NOT NULL,              
    Descricao TEXT,                          
    Preco DECIMAL(10, 2) NOT NULL,           
    Estoque INT DEFAULT 0,                   
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP 
);
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY AUTO_INCREMENT,    
    ClienteID INT NOT NULL,                     
    DataPedido DATETIME DEFAULT CURRENT_TIMESTAMP, 
    StatusPedido VARCHAR(50) DEFAULT 'Pendente',
    ValorTotal DECIMAL(10, 2) DEFAULT 0.00,   
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID) ON DELETE RESTRICT 
);
CREATE TABLE Pedidos_Produtos (
    PedidoProdutoID INT PRIMARY KEY AUTO_INCREMENT, 
    PedidoID INT NOT NULL,                          
    ProdutoID INT NOT NULL,                         
    Quantidade INT NOT NULL CHECK (Quantidade > 0), 
    PrecoUnitario DECIMAL(10, 2) NOT NULL,         
    UNIQUE (PedidoID, ProdutoID), 
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID) ON DELETE CASCADE, 
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID) ON DELETE RESTRICT 
);
CREATE INDEX idx_clientes_email ON Clientes(Email);
CREATE INDEX idx_produtos_nome ON Produtos(Nome);
CREATE INDEX idx_pedidos_clienteid ON Pedidos(ClienteID);
CREATE INDEX idx_pedidos_status ON Pedidos(StatusPedido);
CREATE INDEX idx_pedidos_produtos_produtoid ON Pedidos_Produtos(ProdutoID);
