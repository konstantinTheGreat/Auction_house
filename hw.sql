CREATE DATABASE Auction_House;
CREATE SCHEMA Auction_House_Schema;
SET search_path TO Auction_House_Schema;

CREATE TABLE Items (
    id SERIAL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    starting_price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Lots (
    id SERIAL PRIMARY KEY,
    Lot_number INT NOT NULL
);

CREATE TABLE Items_Lots (
    id SERIAL PRIMARY KEY,
    item_id INT NOT NULL,
    lot_id INT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES Items(id),
    FOREIGN KEY (lot_id) REFERENCES Lots(id)
);

CREATE TABLE Auctions (
    id SERIAL PRIMARY KEY,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL
);

CREATE TABLE lots_auctions (
    lots_auctions_id SERIAL PRIMARY KEY,
    lots_id INT NOT NULL,
    auctions_id INT NOT NULL,
    FOREIGN KEY (lots_id) REFERENCES Lots(id),
    FOREIGN KEY (auctions_id) REFERENCES Auctions(id)
);

CREATE TABLE Sellers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contacts VARCHAR(255) NOT NULL
);

CREATE TABLE SellersAuctions (
    Seller_Auction_id SERIAL PRIMARY KEY,
    sellers_id INT NOT NULL,
    auctions_id INT NOT NULL,
    FOREIGN KEY (sellers_id) REFERENCES Sellers(id),
    FOREIGN KEY (auctions_id) REFERENCES Auctions(id)
);

CREATE TABLE Sellers_Items (
    sellers_items_id SERIAL PRIMARY KEY,
    sellers_id INT NOT NULL,
    item_id INT NOT NULL,
    FOREIGN KEY (sellers_id) REFERENCES Sellers(id),
    FOREIGN KEY (item_id) REFERENCES Items(id)
);

CREATE TABLE Buyers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info VARCHAR(255) NOT NULL
);

CREATE TABLE Purchases (
    id SERIAL PRIMARY KEY,
    item_id INT NOT NULL,
    buyer_id INT NOT NULL,
    price_paid DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10, 2) GENERATED ALWAYS AS (price_paid * quantity) STORED,
    purchase_date DATE NOT NULL,
    FOREIGN KEY (item_id) REFERENCES Items(id),
    FOREIGN KEY (buyer_id) REFERENCES Buyers(id)
);
ALTER TABLE Auctions
ADD CONSTRAINT chk_date CHECK (date > '2000-01-01');
ALTER TABLE Purchases
ADD CONSTRAINT chk_price_paid CHECK (price_paid >= 0);
ALTER TABLE Buyers
ADD COLUMN gender VARCHAR(10);
ALTER TABLE Buyers
ADD CONSTRAINT chk_gender CHECK (gender IN ('Male', 'Female', 'Other'));
ALTER TABLE Buyers
ADD CONSTRAINT unique_contact_info UNIQUE (contact_info);
ALTER TABLE Buyers
ALTER COLUMN contact_info SET NOT NULL;
INSERT INTO Items (description, starting_price) VALUES
  ('Antique Painting', 500.00),
  ('Vintage Watch', 200.00);
INSERT INTO Lots (Lot_number) VALUES
  (1),
  (2);

INSERT INTO Items_Lots (item_id, lot_id) VALUES
  (1, 1),
  (2, 2);

INSERT INTO Auctions (location, date) VALUES
  ('City Auction House', '2023-12-01'),
  ('Country Auction Hall', '2023-12-15');

INSERT INTO lots_auctions (lots_id, auctions_id) VALUES
  (1, 1),
  (2, 2);

INSERT INTO Sellers (name, contacts) VALUES
  ('Seller1', 'seller1@example.com'),
  ('Seller2', 'seller2@example.com');

INSERT INTO SellersAuctions (sellers_id, auctions_id) VALUES
  (1, 1),
  (2, 2);

INSERT INTO Sellers_Items (sellers_id, item_id) VALUES
  (1, 1),
  (2, 2);

INSERT INTO Buyers (name, contact_info, gender) VALUES
  ('Buyer1', 'buyer1@example.com', 'Male'),
  ('Buyer2', 'buyer2@example.com', 'Female');


INSERT INTO Purchases (item_id, buyer_id, price_paid, quantity, purchase_date) VALUES
  (1, 1, 550.00, 1, '2023-12-02'),
  (2, 2, 220.00, 2, '2023-12-10');

ALTER TABLE Items
ADD COLUMN record_ts DATE DEFAULT current_date;

ALTER TABLE Lots
ADD COLUMN record_ts DATE DEFAULT current_date;

ALTER TABLE Items_Lots
ADD COLUMN record_ts DATE DEFAULT current_date;

ALTER TABLE Auctions
ADD COLUMN record_ts DATE DEFAULT current_date;

ALTER TABLE lots_auctions
ADD COLUMN record_ts DATE DEFAULT current_date;

ALTER TABLE Sellers
ADD COLUMN record_ts DATE DEFAULT current_date;

ALTER TABLE SellersAuctions
ADD COLUMN record_ts DATE DEFAULT current_date;

ALTER TABLE Sellers_Items
ADD COLUMN record_ts DATE DEFAULT current_date;

ALTER TABLE Buyers
ADD COLUMN record_ts DATE DEFAULT current_date;

ALTER TABLE Purchases
ADD COLUMN record_ts DATE DEFAULT current_date;


