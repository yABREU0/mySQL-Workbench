CREATE DATABASE Abreu;
use Abreu;

CREATE TABLE clientes (
id_cliente INT PRIMARY KEY,
nome VARCHAR(100),
cidade VARCHAR(100),
UF VARCHAR(2),
data_cadastro DATE
);
CREATE TABLE categorias (
id_categoria INT PRIMARY KEY,
nome_categoria VARCHAR(100)
);
CREATE TABLE produto (
id_produto INT PRIMARY KEY,
descricao VARCHAR(100),
preco_unitario FLOAT,
Estoque INT,
id_categoria INT,
FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);
CREATE TABLE vendas (
	id_venda INT PRIMARY KEY,
    id_cliente INT,
	id_produto INT,
    quantidade INT,
    data_venda DATE,
	FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- CLIENTES (ID Cliente, Nome, Cidade, UF, Data Cadastro)
INSERT INTO clientes (id_cliente, nome, cidade, UF, data_cadastro)
VALUES 
(10, 'Ana Silva', 'São Paulo', 'SP', '2023-01-15'),
(11, 'Bruno Souza', 'Curitiba', 'PR', '2023-05-20'),
(12, 'Carla Dias', 'São Paulo', 'SP', '2024-02-10'),
(13, 'Diego Lemos', 'Belo Horizonte', 'MG', '2024-03-01');

-- CATEGORIAS (ID_Categoria, Nome Categoria)
INSERT INTO categorias (id_categoria, nome_categoria)
VALUES 
(1, 'Eletrônicos'),
(2, 'Moveis'),
(3, 'Informática');

-- PRODUTOS (ID Produto, Descricao, Preco Unitario, Estoque, FK Categoria)
INSERT INTO produtos (id_produto, descricao, preco_unitario, estoque, id_categoria)
VALUES 
(101, 'Smartphone X', 2500.00, 50, 1),
(102, 'Cadeira Gamer', 1200.00, 15, 2),
(103, 'Mouse Sem Fio', 150.00, 100, 3),
(104, 'Monitor 4Κ', 3200.00, 10, 3),
(105, 'Mesa de Escritório', 850.00, 8, 2);

-- VENDAS (ID Venda, FK Cliente, FK Produto, Quantidade, Data_Venda)
INSERT INTO vendas (id_venda, id_cliente, id_produto, quantidade, data_venda)
VALUES (1001, 10, 101, 1, '2024-03-10'),
		(1002, 11, 102, 2, '2024-03-12'),
		(1003, 10, 103, 5, '2024-03-15'),
		(1004, 12, 101, 1, '2024-03-20'),
		(1005, 13, 105, 1, '2024-03-22'),
		(1006, 10, 104, 1, '2024-03-25');

-- A) Visão de Produtos e Preços
-- Qual o preço do produto mais caro da categoria 3 (Informática)?
SELECT MAX(preco_unitario)
FROM produtos
WHERE id_categoria = 3;

--  Qual o preço do produto mais barato da categoria 2 (Móveis)?
SELECT MIN(preco_unitario)
FROM produtos
WHERE id_categoria = 2;

-- Quantos produtos diferentes temos cadastrados em cada categoria?
SELECT id_categoria AS 'Categoria', COUNT(*) AS 'Quantidade'
FROM produtos
GROUP BY id_categoria;

-- B) Visão de Vendas e Clientes
-- Qual foi o valor máximo vendido em uma única unidade para clientes da cidade de 'São Paulo'?
SELECT MAX((preco_unitario * quantidade)) AS 'Venda mais cara'
FROM vendas v
INNER JOIN produtos p
	ON v.id_produto = p.id_produto
INNER JOIN clientes c
	ON v.id_cliente = c.id_cliente
WHERE c.cidade = 'São Paulo';

--  Qual a quantidade total de itens vendidos para o produto 101
SELECT SUM(quantidade) AS 'total de itens vendidos para o produto 101'
FROM vendas
WHERE id_produto = 101;

-- Qual o maior valor de produto vendido no período de 15/03/2024 a 25/03/2024?
SELECT MAX(preco_unitario) AS 'Maior Valor'
FROM vendas v
INNER JOIN produtos p
ON v.id_produto = p.id_produto
WHERE data_venda BETWEEN '2004-03-15' AND '2024-03-25';


-- Tente executar este comando e explique o resultado:
INSERT INTO vendas VALUES (2000, 99, 101, 1, '2024-04-01');

-- Está dando erro porque não está reverenciando os campos da tabela vendas em que vai inserir os dados


