
-- Switch the context to the 'master' database
Use master;
GO

-- If our DB already exists, drop it.
DROP DATABASE IF EXISTS WalkCLE;

-- Create the ArtGallery DB
CREATE DATABASE WalkCLE;
GO

-- Use the new database
USE WalkCLE;
GO

CREATE TABLE Category (
	Id		int IDENTITY(1,1) PRIMARY KEY,
	Name	nvarchar(30) NOT NULL
);

CREATE TABLE Badge (
	Id		int IDENTITY(1,1) PRIMARY KEY,
	Name	nvarchar(30) NOT NULL
);

CREATE TABLE Location (
	Id			int IDENTITY(1,1) PRIMARY KEY,
	Name		nvarchar(50) NOT NULL,
	ShortDesc	nvarchar(40),
	LongDesc	nvarchar(1000),
	-- hours/days open
	Latitude	decimal(9,6),
	Longitude	decimal(9,6),
	Address		nvarchar(100),
	Image		nvarchar(1000),
	PhoneNum	nvarchar(20),
	PriceLevel	int,
	WebsiteURL	nvarchar(1000),
);

CREATE TABLE Location_Category (
	Location_Id int NOT NULL,
	Category_Id int NOT NULL,
	CONSTRAINT FK_Location_Category_Loc FOREIGN KEY (Location_Id) REFERENCES Location(Id),
	CONSTRAINT FK_Location_Category_Cat FOREIGN KEY (Category_Id) REFERENCES Category(Id)
);

CREATE TABLE Users (
	Id			int IDENTITY(1,1) PRIMARY KEY,
	Username	nvarchar(50) NOT NULL,
	Password	nvarchar(50) NOT NULL,
	Salt		nvarchar(50) NOT NULL,
	Role		nvarchar(50) DEFAULT('user')
);

CREATE TABLE CheckIn (
	UserId int NOT NULL,
	LocationId int NOT NULL,
	CONSTRAINT FK_CheckIn_Users FOREIGN KEY (UserId) REFERENCES Users(Id),
	CONSTRAINT FK_CheckIn_Location FOREIGN KEY (LocationId) REFERENCES Location(Id)
);

CREATE TABLE UserBadge (
	UserId int NOT NULL,
	BadgeId int NOT NULL,
	CONSTRAINT FK_UserBadge_Users FOREIGN KEY (UserId) REFERENCES Users(Id),
	CONSTRAINT FK_UserBadge_Badge FOREIGN KEY (BadgeId) REFERENCES Badge(Id)
);




