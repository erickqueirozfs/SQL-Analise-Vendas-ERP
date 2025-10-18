create database erp_db;
use `erp_db`;

-- Tabela Categorias
-- ---------------------------
-- Criação da tabela
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY auto_increment,
    CategoryName VARCHAR(50),
    Description text
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Categories.csv'
INTO TABLE Categories
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY '.'                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ---------------------------
-- Tabela Customers
-- ---------------------------
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY auto_increment,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Address VARCHAR(255),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    Country VARCHAR(50)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY '.'                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
select * from Customers;
-- ---------------------------
-- Tabela OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY auto_increment,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/OrderDetails.csv'
INTO TABLE OrderDetails
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY '.'                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- adicionando chave estrangeiras
alter table OrderDetails add foreign key (OrderID) references Orders(OrderID);
alter table OrderDetails add foreign key (ProductID) references Products(ProductID);

-- ---------------------------
-- Tabela Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY auto_increment,
    LastName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    Photo VARCHAR(100),
    Notes TEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Employees.csv'
INTO TABLE Employees
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY '.'                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(EmployeeID,LastName,FirstName,@BirthDate,Photo,Notes)
set BirthDate=str_to_date(@BirthDate,"%d/%m/%Y");
select * from Employees;

-- ---------------------------
-- Tabela Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY auto_increment,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    OrderDate DATE NOT NULL,
    ShipperID INT NOT NULL
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY '.'                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OrderID, CustomerID, EmployeeID, @OrderDate, ShipperID)
SET OrderDate = STR_TO_DATE(@OrderDate, '%d/%m/%Y');
select * from Orders;

-- adicionando chaves estrangeiras
alter table Orders add foreign key (CustomerID) references Customers(CustomerID);
alter table Orders add foreign key (EmployeeID) references Employees(EmployeeID);
alter table Orders add foreign key (ShipperID) references Shippers(ShipperID);

-- ---------------------------
-- Tabela Produtos

CREATE TABLE Products (
    ProductID INT PRIMARY KEY auto_increment,
    ProductName VARCHAR(100),
    SupplierID INT,
    CategoryID INT,
    Unit VARCHAR(100),
    Price DECIMAL(10,2)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Products.csv'
INTO TABLE Products
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY '.'                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ProductID,ProductName,SupplierID,CategoryID,Unit,@Price)
set price=replace(@Price,",",".");

alter table Products add foreign key (SupplierID) references Suppliers(SupplierID);
alter table Products add foreign key (CategoryID) references Categories(CategoryID);

-- ---------------------------
-- Tabela Shippers
CREATE TABLE Shippers (
    ShipperID INT PRIMARY KEY auto_increment,
    ShipperName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Shippers.csv'
INTO TABLE Shippers
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY '.'                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ---------------------------
-- Tabela Suppliers
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY auto_increment,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    Address VARCHAR(150),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    Country VARCHAR(50),
    Phone VARCHAR(30)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Suppliers.csv'
INTO TABLE Suppliers
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY '.'                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;