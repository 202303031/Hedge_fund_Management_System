CREATE DATABASE  Hedge_Fund; 
CREATE SCHEMA IF NOT EXISTS Ams; 
SET SEARCH_Path to Ams; 
CREATE TABLE Ams.User ( 
    UserId VARCHAR(6) PRIMARY KEY, 
    UserName Varchar(50) Not null, 
    Email  Varchar(100) not null, 
    PassWord Varchar(255) not null 
); 
 
CREATE TABLE Ams.Portfolio ( 
    PortfolioID DECIMAL(9,0) PRIMARY KEY, 
    CreationDate DATE NOT NULL, 
    UserId VARCHAR(6) , 
    FOREIGN KEY (UserId) REFERENCES Ams.User(UserId) 
    ON UPDATE CASCADE ON DELETE SET NULL 
); 
 
CREATE TABLE Ams.AdminLog ( 
    UserID VARCHAR(6) Not null, 
    ActionType VARCHAR(50) NOT NULL, 
    ActionDate TIMESTAMP NOT NULL 
); 
 
CREATE TABLE ams.Position ( 
   UserID VARCHAR(80) NOT NULL, 
   Role VARCHAR(20) CHECK IN ('Admin','Manager','Broker','Invester'),  
   Access VARCHAR(50)  
); 
 
CREATE TABLE Ams.Asset ( 
    AssetID INT PRIMARY KEY, 
    AssetName VARCHAR(100) NOT NULL, 
    NAV numeric(10,4) not null  
); 
CREATE TABLE Ams.AssetData ( 
    AssetID INT not NULL, 
    Date DATE NOT NULL, 
    NAV numeric(10,4) not null  
); 
CREATE TABLE Ams.Transection ( 
    TransactionID INT PRIMARY KEY, 
    Amount INT , 
    PortfolioID INT FOREIGN KEY, 
    AssetID INT, 
    TransactionType VARCHAR(50) NOT NULL CHECK IN ('Buy','Sell'), 
    Time TIMESTAMP , 
    unit numeric(10,4)  , 
    FOREIGN KEY (PortfolioID) REFERENCES Ams.Portfolio(PortfolioID) 
    ON UPDATE CASCADE ON DELETE CASCADE 
); 
CREATE TABLE Ams.SupportTicket ( 
   TicketID INT PRIMARY KEY, 
    Status VARCHAR(50) NOT NULL CHECK IN ('Open','Close','Pending'), 
    UserId VARCHAR(80), 
    CreationTime TIMESTAMP NOT NULL, 
    Issue TEXT NOT NULL, 
    Endtime TIMESTAMP NOT NULL, 
    FOREIGN KEY (UserId) REFERENCES Hedge_Funds.User(UserId) 
    ON UPDATE CASCADE ON DELETE CASCADE 
); 
 
ALTER TABLE IF EXISTS ams.portfolio 
    ADD CONSTRAINT portfolio_portfolioname_check CHECK (portfolioname::text = 
ANY (ARRAY['Direct'::character varying, 'Regular'::character 
varying]::text[])); 
 
ALTER TABLE IF EXISTS ams."user" 
    ADD CONSTRAINT user_userid_check CHECK (userid::text ~ '^[A-Za-z]{3}[0
9]{3}$'::text); 
 
ALTER TABLE IF EXISTS ams."position" 
    ADD CONSTRAINT position_role_check CHECK (role::text = ANY 
(ARRAY['Admin'::character varying, 'User'::character varying, 
'Manager'::character varying, 'Investor'::character varying, 
'Broker'::character varying]::text[])); 