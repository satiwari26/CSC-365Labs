-- Lab 2
-- satiwari
-- Oct 7, 2023

//SQL DDL commands
//creating the structure of the bakery DATABASE

CREATE TABLE Customers (
    CID INTEGER NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    PRIMARY KEY (CID)
);

CREATE TABLE Goods (
    GID VARCHAR(50) NOT NULL,
    Flavour VARCHAR(100) NOT NULL,
    Food VARCHAR(100) NOT NULL,
    Price DECIMAL NOT NULL,
    PRIMARY KEY (GID)
);

CREATE TABLE Receipts (
    Rnumber INTEGER NOT NULL,
    SaleDate DATE NOT NULL,
    customerID INTEGER NOT NULL,
    PRIMARY KEY (Rnumber),
    FOREIGN KEY (customerID) REFERENCES Customers (CID)
);


CREATE TABLE Items (
    Receipt INTEGER NOT NULL,
    Ordinal INTEGER NOT NULL,
    Item VARCHAR(100) NOT NULL,
    PRIMARY KEY (Receipt, Ordinal),
    FOREIGN KEY (Receipt) REFERENCES Receipts (Rnumber),
    FOREIGN KEY (Item) REFERENCES Goods (GID)
);

ALTER TABLE Customers RENAME TO customers;

ALTER TABLE goods
CHANGE COLUMN Flavour Flavor VARCHAR(100);

ALTER TABLE goods
ADD CONSTRAINT unique_flavor_food UNIQUE (Flavor, Food);

ALTER TABLE Receipts RENAME TO receipts;

ALTER TABLE receipts
CHANGE COLUMN customerID customer INTEGER;

ALTER TABLE Items RENAME TO items;

DROP TABLE items;

DROP TABLE receipts;

CREATE TABLE receipts (
    Rnumber varchar(100) NOT NULL,
    SaleDate DATE NOT NULL,
    customer INTEGER NOT NULL,
    PRIMARY KEY (Rnumber),
    FOREIGN KEY (customer) REFERENCES customers (CID)
);

CREATE TABLE items (
    Receipt varchar(100) NOT NULL,
    Ordinal INTEGER NOT NULL,
    Item VARCHAR(100) NOT NULL,
    PRIMARY KEY (Receipt, Ordinal),
    FOREIGN KEY (Receipt) REFERENCES receipts (Rnumber),
    FOREIGN KEY (Item) REFERENCES goods (GID)
);

ALTER TABLE goods
MODIFY price DECIMAL(4, 2);
