
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

INSERT category (Name) VALUES ('Museum')
INSERT category (Name) VALUES ('Garden')
INSERT category (Name) VALUES ('Art Gallery')
INSERT category (Name) VALUES ('Zoo')
INSERT category (Name) VALUES ('Wildlife')
INSERT category (Name) VALUES ('Aquarium')
INSERT category (Name) VALUES ('Memorial')
INSERT category (Name) VALUES ('Historic Place')
INSERT category (Name) VALUES ('Architecture')
INSERT category (Name) VALUES ('Sculpture')
INSERT category (Name) VALUES ('Unusual Attraction')
INSERT category (Name) VALUES ('Tour')

INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('Cleveland Museum of Natural History', 'Museum of the natural world', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.509950, -81.609890, '1 Wade Oval Drive', '', '(216) 231-4600', '', 'https://www.cmnh.org/')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('Great Lakes Science Center', 'Interactive Science Museum', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.507290, -81.696640, '601 Erieside Ave', '', '(216) 694-2000', '', 'http://greatscience.com/')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('Cleveland Botanical Garden', 'Botanical Gardens', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.508420, -81.611690, '11030 E Blvd', '', '(216) 721-1600', '', 'https://cbgarden.org/')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('A Christmas Story House', 'Movie Location', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.468730, -81.687250, '3159 W 11th St', '', '3159 W 11th St', '', 'https://www.achristmasstoryhouse.com/')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('Cleveland Museum of Art', 'Art Museum', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.509520, -81.612180, '11150 East Blvd', '', '(216) 421-7350', '', 'https://www.clevelandart.org/')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('Cleveland Metroparks Zoo', 'Zoo', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.446980, -81.711890, '3900 Wildlife Way', '', '(216) 661-6500', '', 'https://www.clevelandmetroparks.com/zoo')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('Greater Cleveland Aquarium', 'Aquarium', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.496540, -81.703770, '2000 Sycamore St', '', '(216) 862-8803', '', 'https://www.greaterclevelandaquarium.com/')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('James A. Garfield Memorial', 'Monument', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.518160, -81.519840, '1534 S Green Rd', '', '(216) 381-2953', '', 'https://garfieldchurch.org/')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('Rock & Roll Hall of Fame and Museum', 'Museum of Rock & Roll', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.508550, -81.695430, '1100 Rock And Roll Blvd', '', '(216) 781-7625', '', 'https://www.rockhall.com/')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('Cleveland History Center', 'Museum of Cleveland', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.513900, -81.610330, '10825 East Blvd', '', '(216) 721-5722', '', 'https://www.wrhs.org/')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('Terminal Tower', 'Clevelands Signature landmark', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.500100, -81.694650, '50 Public Sq', '', '(216) 621-6060', '', '')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('Steamship William G. Mather Maritime Museum', 'Ore Boat Museum', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.509180,  -81.694700, '1001 E 9th St, North Coast Harbor Park', '', '(216) 574-6262', '', '')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('Soldiers and Sailors Monument', 'Monument', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.499750, -81.692530, '3 Public Sq', '', '(216) 621-3710', '', 'http://www.soldiersandsailors.com/')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('Playhouse Square', 'Outdoor Chandelier', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.500670, -81.680910, '1501 Euclid Ave Ste 200', '', '1501 Euclid Ave Ste 200', '', 'https://theatrecleveland.com/')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('USS Cod Submarine', 'WWII Submarine Museum', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.510950, -81.688040, '1201 N Marginal Rd', '', ' 1201 N Marginal Rd', '', 'http://usscod.org/')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL) VALUES ('Federal Reserve Bank of Cleveland', 'Money Museum', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.502050, -81.690270, '1455 E 6th St', '', '(216) 579-2000', '', 'https://www.clevelandfed.org/')

