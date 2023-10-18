CREATE TABLE CountryData (
    Country VARCHAR(255) NOT NULL,
    Region VARCHAR(255) NOT NULL,
    Population INT NOT NULL,
    Area DECIMAL(12, 2) NOT NULL,
    PopDensity DECIMAL(12, 2) NOT NULL,
    Coastline DECIMAL(12, 2) NOT NULL,
    NetMigration DECIMAL(12, 2) NOT NULL,
    InfantMortality DECIMAL(12, 2) NOT NULL,
    GDP DECIMAL(12, 2) NOT NULL,
    Literacy DECIMAL(12, 2) NOT NULL,
    PhonesPer1000 DECIMAL(12, 2) NOT NULL,
    Arable DECIMAL(12, 2) NOT NULL,
    Crops DECIMAL(12, 2) NOT NULL,
    Other DECIMAL(12, 2) NOT NULL,
    Climate DECIMAL(12, 2) NOT NULL,
    Birthrate DECIMAL(12, 2) NOT NULL,
    Deathrate DECIMAL(12, 2) NOT NULL,
    Agriculture DECIMAL(12, 2) NOT NULL,
    Industry DECIMAL(12, 2) NOT NULL,
    Service DECIMAL(12, 3) NOT NULL,
    PRIMARY KEY (Country)
);

CREATE TABLE FoodPrice (
    Price_ID INT not null,
    Country_Name VARCHAR(255)not null,
    Region_ID INT not null,
    Region_Name VARCHAR(255) not null,
    Market_ID INT not null,
    Market_Name VARCHAR(255) not null,
    Commodity_ID INT not null,
    Commodity_Name VARCHAR(255) not null,
    Currency_ID INT not null,
    Currency_Name VARCHAR(255) not null,
    Price_Type_ID INT not null,
    Price_Type_Name VARCHAR(255) not null,
    Weight_Unit_ID INT not null,
    Weight_Unit_Name VARCHAR(255) not null,
    Month INT not null,
    Year INT not null,
    Price_Per_Unit DECIMAL(10, 2) not null,
    Source VARCHAR(255) not null,
    primary key (Price_ID),
    FOREIGN KEY (Country_Name) REFERENCES CountryData(Country)
);

CREATE TABLE FoodWaste (
    Country VARCHAR(255),
    Combined_Figures_Kg_Capita_Year INT not null,
    Household_Estimate_Kg_Capita_Year INT not null,
    Household_Estimate_Tonnes_Year BIGINT not null,
    Retail_Estimate_Kg_Capita_Year INT not null,
    Retail_Estimate_Tonnes_Year BIGINT not null,
    Food_Service_Estimate_Kg_Capita_Year INT not null,
    Food_Service_Estimate_Tonnes_Year BIGINT not null,
    Confidence_In_Estimate VARCHAR(255) not null,
    M49_Code INT not null,
    Region VARCHAR(255) not null,
    Source VARCHAR(255) not null,
	primary key (Country),
	FOREIGN KEY (Country) REFERENCES CountryData(Country)
);


