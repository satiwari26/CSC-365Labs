-- Lab 2
-- satiwari
-- Oct 7, 2023


//populating backery with data.


//populating customers data
INSERT INTO customers (CId, FirstName, LastName) VALUES (1, 'JULIET', 'LOGAN');
INSERT INTO customers (CId, FirstName, LastName) VALUES (2, 'TERRELL', 'ARZT');
INSERT INTO customers (CId, FirstName, LastName) VALUES (3, 'TRAVIS', 'ESPOSITA');
INSERT INTO customers (CId, FirstName, LastName) VALUES (4, 'SIXTA', 'ENGLEY');
INSERT INTO customers (CId, FirstName, LastName) VALUES (5, 'OSVALDO', 'DUNLOW');
INSERT INTO customers (CId, FirstName, LastName) VALUES (6, 'JOSETTE', 'SLINGLAND');
INSERT INTO customers (CId, FirstName, LastName) VALUES (7, 'SHARRON', 'TOUSSAND');
INSERT INTO customers (CId, FirstName, LastName) VALUES (8, 'RUPERT', 'HELING');
INSERT INTO customers (CId, FirstName, LastName) VALUES (9, 'CUC', 'HAFFERKAMP');
INSERT INTO customers (CId, FirstName, LastName) VALUES (10, 'CORETTA', 'DUKELOW');
INSERT INTO customers (CId, FirstName, LastName) VALUES (11, 'MIGDALIA', 'STADICK');
INSERT INTO customers (CId, FirstName, LastName) VALUES (12, 'MELLIE', 'MCMAHAN');
INSERT INTO customers (CId, FirstName, LastName) VALUES (13, 'KIP', 'ARNN');
INSERT INTO customers (CId, FirstName, LastName) VALUES (14, 'RAYFORD', 'S\'OPKO');
INSERT INTO customers (CId, FirstName, LastName) VALUES (15, 'DAVID', 'CALLENDAR');
INSERT INTO customers (CId, FirstName, LastName) VALUES (16, 'ARIANE', 'CRUZEN');
INSERT INTO customers (CId, FirstName, LastName) VALUES (17, 'CHARLENE', 'MESDAQ');
INSERT INTO customers (CId, FirstName, LastName) VALUES (18, 'ALMETA', 'DOMKOWSKI');
INSERT INTO customers (CId, FirstName, LastName) VALUES (19, 'NATACHA', 'STENZ');
INSERT INTO customers (CId, FirstName, LastName) VALUES (20, 'STEPHEN', 'ZEME');


//populating the goods data:
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('20-BC-C-10', 'Chocolate', 'Cake', 8.95);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('20-BC-L-10', 'Lemon', 'Cake', 8.95);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('20-CA-7.5', 'Casino', 'Cake', 15.95);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('24-8x10', 'Opera', 'Cake', 15.95);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('25-STR-9', 'Strawberry', 'Cake', 11.95);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('26-8x10', 'Truffle', 'Cake', 15.95);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('45-CH', 'Chocolate', 'Eclair', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('45-CO', 'Coffee', 'Eclair', 3.5);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('45-VA', 'Vanilla', 'Eclair', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('46-11', 'Napoleon', 'Cake', 13.49);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-ALM-I', 'Almond', 'Tart', 3.75);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-APIE-10', 'Apple', 'Pie', 5.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-APP-11', 'Apple', 'Tart', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-APR-PF', 'Apricot', 'Tart', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-BER-11', 'Berry', 'Tart', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-BLK-PF', 'Blackberry', 'Tart', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-BLU-11', 'Blueberry', 'Tart', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-CH-PF', 'Chocolate', 'Tart', 3.75);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-CHR-11', 'Cherry', 'Tart', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-LEM-11', 'Lemon', 'Tart', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-PEC-11', 'Pecan', 'Tart', 3.75);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-GA', 'Ganache', 'Cookie', 1.15);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-GON', 'Gongolais', 'Cookie', 1.15);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-R', 'Raspberry', 'Cookie', 1.09);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-LEM', 'Lemon', 'Cookie', 0.79);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-M-CH-DZ', 'Chocolate', 'Meringue', 1.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-M-VA-SM-DZ', 'Vanilla', 'Meringue', 1.15);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-MAR', 'Marzipan', 'Cookie', 1.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-TU', 'Tuile', 'Cookie', 1.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-W', 'Walnut', 'Cookie', 0.79);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('50-ALM', 'Almond', 'Croissant', 1.45);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('50-APP', 'Apple', 'Croissant', 1.45);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('50-APR', 'Apricot', 'Croissant', 1.45);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('50-CHS', 'Cheese', 'Croissant', 1.75);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('50-CH', 'Chocolate', 'Croissant', 1.75);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('51-APR', 'Apricot', 'Danish', 1.15);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('51-APP', 'Apple', 'Danish', 1.15);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('51-ATW', 'Almond', 'Twist', 1.15);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('51-BC', 'Almond', 'Bear Claw', 1.95);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('51-BLU', 'Blueberry', 'Danish', 1.15);

DELETE * FROM goods

//re-populating the data with the right precise value
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('20-BC-C-10', 'Chocolate', 'Cake', 8.95);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('20-BC-L-10', 'Lemon', 'Cake', 8.95);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('20-CA-7.5', 'Casino', 'Cake', 15.95);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('24-8x10', 'Opera', 'Cake', 15.95);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('25-STR-9', 'Strawberry', 'Cake', 11.95);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('26-8x10', 'Truffle', 'Cake', 15.95);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('45-CH', 'Chocolate', 'Eclair', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('45-CO', 'Coffee', 'Eclair', 3.5);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('45-VA', 'Vanilla', 'Eclair', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('46-11', 'Napoleon', 'Cake', 13.49);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-ALM-I', 'Almond', 'Tart', 3.75);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-APIE-10', 'Apple', 'Pie', 5.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-APP-11', 'Apple', 'Tart', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-APR-PF', 'Apricot', 'Tart', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-BER-11', 'Berry', 'Tart', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-BLK-PF', 'Blackberry', 'Tart', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-BLU-11', 'Blueberry', 'Tart', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-CH-PF', 'Chocolate', 'Tart', 3.75);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-CHR-11', 'Cherry', 'Tart', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-LEM-11', 'Lemon', 'Tart', 3.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('90-PEC-11', 'Pecan', 'Tart', 3.75);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-GA', 'Ganache', 'Cookie', 1.15);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-GON', 'Gongolais', 'Cookie', 1.15);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-R', 'Raspberry', 'Cookie', 1.09);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-LEM', 'Lemon', 'Cookie', 0.79);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-M-CH-DZ', 'Chocolate', 'Meringue', 1.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-M-VA-SM-DZ', 'Vanilla', 'Meringue', 1.15);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-MAR', 'Marzipan', 'Cookie', 1.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-TU', 'Tuile', 'Cookie', 1.25);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('70-W', 'Walnut', 'Cookie', 0.79);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('50-ALM', 'Almond', 'Croissant', 1.45);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('50-APP', 'Apple', 'Croissant', 1.45);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('50-APR', 'Apricot', 'Croissant', 1.45);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('50-CHS', 'Cheese', 'Croissant', 1.75);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('50-CH', 'Chocolate', 'Croissant', 1.75);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('51-APR', 'Apricot', 'Danish', 1.15);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('51-APP', 'Apple', 'Danish', 1.15);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('51-ATW', 'Almond', 'Twist', 1.15);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('51-BC', 'Almond', 'Bear Claw', 1.95);
INSERT INTO goods (GId, Flavor, Food, Price) VALUES ('51-BLU', 'Blueberry', 'Danish', 1.15);

//populating the receipts table
INSERT INTO receipts (RNumber, Customer, SaleDate) VALUES (18129, 15, '2007-10-28');
INSERT INTO receipts (RNumber, Customer, SaleDate) VALUES (51991, 14, '2007-10-17');
INSERT INTO receipts (RNumber, Customer, SaleDate) VALUES (83085, 7, '2007-10-12');
INSERT INTO receipts (RNumber, Customer, SaleDate) VALUES (70723, 20, '2007-10-28');
INSERT INTO receipts (RNumber, Customer, SaleDate) VALUES (13355, 7, '2007-10-12');
INSERT INTO receipts (RNumber, Customer, SaleDate) VALUES (52761, 8, '2007-10-27');
INSERT INTO receipts (RNumber, Customer, SaleDate) VALUES (99002, 20, '2007-10-13');
INSERT INTO receipts (RNumber, Customer, SaleDate) VALUES (58770, 18, '2007-10-22');
INSERT INTO receipts (RNumber, Customer, SaleDate) VALUES (84665, 6, '2007-10-10');

//populating the items table
INSERT INTO items (Receipt, Ordinal, Item) VALUES (18129, 1, '70-TU');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (51991, 1, '90-APIE-10');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (51991, 2, '90-CH-PF');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (51991, 3, '90-APP-11');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (51991, 4, '26-8x10');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (83085, 1, '25-STR-9');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (83085, 2, '24-8x10');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (83085, 3, '90-APR-PF');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (83085, 4, '51-ATW');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (83085, 5, '26-8x10');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (70723, 1, '45-CO');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (13355, 1, '24-8x10');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (13355, 2, '70-LEM');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (13355, 3, '46-11');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (52761, 1, '90-ALM-I');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (52761, 2, '26-8x10');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (52761, 3, '50-CHS');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (52761, 4, '90-BLK-PF');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (52761, 5, '90-ALM-I');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (99002, 1, '50-CHS');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (99002, 2, '45-VA');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (58770, 1, '50-CHS');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (58770, 2, '46-11');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (58770, 3, '45-CH');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (58770, 4, '20-CA-7.5');
INSERT INTO items (Receipt, Ordinal, Item) VALUES (84665, 1, '90-BER-11');
