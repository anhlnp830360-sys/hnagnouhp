
CREATE DATABASE DB03;
USE DB03;
CREATE TABLE Category (
    CategoryID VARCHAR(10) PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);
CREATE TABLE Product (
    ProductID VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    CategoryID VARCHAR(10) NOT NULL,

    FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID)
);
CREATE TABLE Warehouse (
    WarehouseID VARCHAR(10) PRIMARY KEY,
    WarehouseAddress VARCHAR(255) NOT NULL,
    CategoryID VARCHAR(10) NOT NULL,

    FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID)
);
CREATE TABLE Instock (
    WarehouseID VARCHAR(10),
    ProductID VARCHAR(10),
    Quantity INT NOT NULL,

    PRIMARY KEY (WarehouseID, ProductID),

    FOREIGN KEY (WarehouseID)
        REFERENCES Warehouse(WarehouseID),

    FOREIGN KEY (ProductID)
        REFERENCES Product(ProductID)
);
INSERT INTO Category VALUES
('C01','Beverage'),
('C02','Food'),
('C03','Electronic'),
('C04','Household');
INSERT INTO Product VALUES
('P01','Coca-Cola Original 330ml',10000,'C01'),
('P02','Pepsi Black 330ml',11000,'C01'),
('P03','Red Bull Energy Drink 250ml',15000,'C01'),
('P04','Aquafina Mineral Water 500ml',7000,'C01'),
('P05','C2 Green Tea 455ml',10000,'C01'),
('P06','Oreo Chocolate Cookies 133g',18000,'C02'),
('P07','AFC Vegetable Crackers 200g',25000,'C02'),
('P08','Kinh Do Sandwich Bread',15000,'C02'),
('P09','Vifon Instant Noodles Beef Flavor',5000,'C02'),
('P10','Choco Pie Original Box',42000,'C02'),
('P11','Logitech M185 Wireless Mouse',185000,'C03'),
('P12','Logitech K120 Keyboard',250000,'C03'),
('P13','Kingston DataTraveler 64GB USB',160000,'C03'),
('P14','Samsung EVO Plus 128GB MicroSD',320000,'C03'),
('P15','Xiaomi 20000mAh Power Bank',450000,'C03'),
('P16','Sunlight Lemon Dishwashing Liquid 750ml',42000,'C04'),
('P17','OMO Matic Laundry Detergent 2kg',165000,'C04'),
('P18','Pulppy Facial Tissue Box',28000,'C04'),
('P19','Comfort Fabric Softener 800ml',55000,'C04'),
('P20','Gift Garbage Bag Roll Large Size',25000,'C04');
INSERT INTO Warehouse VALUES
('W01','Thu Duc, Ho Chi Minh City','C01'),
('W02','Cau Giay, Hanoi','C01'),
('W03','Hai Chau, Da Nang','C02'),
('W04','Ninh Kieu, Can Tho','C03'),
('W05','Le Chan, Hai Phong','C04');
INSERT INTO Instock VALUES
('W01','P01',100),
('W01','P02',120),
('W01','P03',80),
('W02','P01',60),
('W02','P02',70),
('W03','P04',200),
('W03','P05',150),
('W03','P06',250),
('W04','P07',50),
('W04','P08',40),
('W04','P09',90),
('W05','P10',100),
('W05','P11',70),
('W05','P12',150),
('W01','P04',20),
('W02','P05',15),
('W04','P10',25),
('W05','P01',30);
