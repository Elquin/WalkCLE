
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
	GoogleURL	nvarchar(1000),
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
	CheckInDate date NOT NULL,
	CONSTRAINT FK_CheckIn_Users FOREIGN KEY (UserId) REFERENCES Users(Id),
	CONSTRAINT FK_CheckIn_Location FOREIGN KEY (LocationId) REFERENCES Location(Id),
	PRIMARY KEY (UserId, LocationId, CheckInDate)
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

INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('Cleveland Museum of Natural History', 'Museum of the natural world', 'Their mission is to inspire, through science and education, a passion for nature, the protection of natural diversity, the fostering of health and leadership to a sustainable future.', 41.509950, -81.609890, '1 Wade Oval Drive', 'Museum of Natural History.jpg', '(216) 231-4600', 3, 'https://www.cmnh.org/', 'https://www.google.com/maps/dir//cleveland+museum+of+natural+history/@41.5116293,-81.6829197,12z/data=!3m1!4b1!4m9!4m8!1m0!1m5!1m1!1s0x8830fb8c55353621:0x38f5d5fedec5891f!2m2!1d-81.61288!2d41.511522!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('Great Lakes Science Center', 'Interactive Science Museum', 'Great Lakes Science Center makes science, technology, engineering and math (STEM) come alive for more than 300,000 visitors a year through hundreds of hands-on exhibits, exhibitions, the Cleveland Clinic DOME Theater, daily science demonstrations, seasonal camps, and more.', 41.507290, -81.696640, '601 Erieside Ave', 'Great Lakes Science Center.jpg', '(216) 694-2000', 3, 'http://greatscience.com/', 'https://www.google.com/maps/dir//Great+Lakes+Science+Center,+Erieside+Avenue,+Cleveland,+OH/@41.5075489,-81.7667734,12z/data=!3m1!4b1!4m9!4m8!1m0!1m5!1m1!1s0x8830f08389cca149:0x44a0a143356f9882!2m2!1d-81.6967337!2d41.5074416!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('Cleveland Botanical Garden', 'Botanical Gardens', 'The Cleveland Botanical Garden, located in the University Circle neighborhood of Cleveland, Ohio, was founded in 1930 as the Garden Center of Greater Cleveland. It was the first such organization in an American city. Originally housed in a converted boathouse on Wade Park Lagoon, the center served as a horticultural library, offering classes and workshops for gardeners and spearheading beautification projects in the community.', 41.508420, -81.611690, '11030 E Blvd', 'cleveland-botanical-garden-13.jpg', '(216) 721-1600', 2, 'https://cbgarden.org/', 'https://www.google.com/maps/dir//Cleveland+Botanical+Garden,+East+Boulevard,+Cleveland,+OH/@41.511227,-81.6796202,12z/data=!3m1!4b1!4m9!4m8!1m0!1m5!1m1!1s0x8830fb8c6b2a2705:0xb3e99d3e8bb7d36!2m2!1d-81.6095805!2d41.5111197!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('A Christmas Story House', 'Movie set for ''A Christmas Story''', 'A Christmas Story House is an attraction and museum in Cleveland, Ohio''s Tremont neighborhood. The 19th-century Victorian, which was used in the exterior and some interior scenes of Ralphie Parker''s house in the 1983 film A Christmas Story, was purchased by a private developer in 2004 and has been restored and renovated to appear as it did both inside and outside in the film. The museum is part of a complex of four buildings devoted to the film, and is open to the public year-round.', 41.468730, -81.687250, '3159 W 11th St', 'A Christmas Story House.jpg', '3159 W 11th St', 2, 'https://www.achristmasstoryhouse.com/', 'https://www.google.com/maps/dir//A+Christmas+Story+House,+West+11th+Street,+Cleveland,+OH/@41.4688366,-81.7574328,12z/data=!3m1!4b1!4m9!4m8!1m0!1m5!1m1!1s0x8830faa8ec56056d:0xd38f32e458bdbe19!2m2!1d-81.6873931!2d41.4687292!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('Cleveland Museum of Art', 'Cleveland Art Museum', 'The Cleveland Museum of Art creates transformative experiences through art, “for the benefit of all the people forever.” The Cleveland Museum of Art is renowned for the quality and breadth of its collection, which includes more than 61,000 objects and spans 6,000 years of achievement in the arts. The museum is a significant international forum for exhibitions, scholarship, and performing arts. One of the top comprehensive art museums in the nation and free of charge to all, the Cleveland Museum of Art is located in the dynamic University Circle neighborhood.', 41.509520, -81.612180, '11150 East Blvd', 'Cleveland Museum of Art.png', '(216) 421-7350', 0, 'https://www.clevelandart.org/', 'https://www.google.com/maps/dir//The+Cleveland+Museum+of+Art,+11150+East+Blvd,+Cleveland,+OH+44106/@41.5091484,-81.68211,12z/data=!3m1!4b1!4m9!4m8!1m0!1m5!1m1!1s0x8830fb8dd37a09d9:0x24667546af3346a!2m2!1d-81.6120703!2d41.5090411!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('Cleveland Metroparks Zoo', 'Cleveland Zoo', 'The Cleveland Metroparks Zoo is a 183-acre zoo in Cleveland, Ohio. The Zoo is divided into several areas: Australian Adventure; African Savanna; Northern Wilderness Trek, The Primate, Cat & Aquatics Building, Waterfowl Lake, The RainForest, and the newly added Asian Highlands. Cleveland Metroparks Zoo has one of the largest collections of primates in North America, The Zoo is a part of the Cleveland Metroparks system.', 41.446980, -81.711890, '3900 Wildlife Way', 'Cleveland Metroparks Zoo.jpg', '(216) 661-6500', 3, 'https://www.clevelandmetroparks.com/zoo', 'https://www.google.com/maps/dir//Cleveland+Metroparks+Zoo,+Wildlife+Way,+Cleveland,+OH/@41.4460418,-81.7826531,12z/data=!3m1!4b1!4m9!4m8!1m0!1m5!1m1!1s0x8830efeb8cac86db:0xa3032f5bfedceb23!2m2!1d-81.7126134!2d41.4459344!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('Greater Cleveland Aquarium', 'Cleveland Aquarium', 'The Greater Cleveland Aquarium is an aquarium in Cleveland, Ohio, USA. Occupying the historic FirstEnergy Powerhouse building located on the west bank of the Cuyahoga River in the city''s Flats district, the aquarium, which opened in January 2012, consists of approximately 70,000 square feet of exhibition space and features 55 exhibits over 9 thematic concentrations representing both local and exotic species of fish. The facility is the only independent, free-standing aquarium in the state of Ohio and ended a 26-year period that the city lacked a public aquarium', 41.496540, -81.703770, '2000 Sycamore St', 'Greater-Cleveland-Aquarium-Logo.png', '(216) 862-8803', 3, 'https://www.greaterclevelandaquarium.com/', 'https://www.google.com/maps/dir//Greater+Cleveland+Aquarium,+2000+Sycamore+St,+Cleveland,+OH+44113/@41.4966466,-81.7738443,12z/data=!3m1!4b1!4m9!4m8!1m0!1m5!1m1!1s0x8830f063645f17c9:0x25b1bed23e15c3c2!2m2!1d-81.7038046!2d41.4965393!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('James A. Garfield Memorial', 'James Garfield Memorial', 'The James A. Garfield Memorial was built in memory of the 20th U.S. President, James A. Garfield, who was assassinated in 1881. The memorial is located at 12316 Euclid Avenue in Lake View Cemetery in Cleveland, Ohio. The country grieved for his loss almost as much as they had done for Lincoln, 16 years previously. In Washington, 100,000 plus citizens visited his casket, lying in state in the Capitol. Part of the memorial''s funding came from pennies sent in by children throughout the country.', 41.518160, -81.519840, '1534 S Green Rd', 'Garfield_Memorial_2013-09-14_17-58-11.jpg', '(216) 381-2953', 0, 'https://garfieldchurch.org/', 'https://www.google.com/maps/dir//James+A.+Garfield+Monument,+Euclid+Ave,+Cleveland,+OH/@41.5101917,-81.6613762,12z/data=!3m1!4b1!4m9!4m8!1m0!1m5!1m1!1s0x8830fc0ca90631eb:0x95d08eabbed27e1f!2m2!1d-81.5913365!2d41.5100844!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('Rock & Roll Hall of Fame and Museum', 'Museum of Rock & Roll', 'The Rock and Roll Hall of Fame is alive with the energy, passion and the spirit of music we celebrate. The 150,000 square-foot museum features seven floors, four theaters for films and ever-changing exhibits. Get a front row feeling for 30+ years of induction performance highlights through the all-new Power of Rock Experience. You can spend as little as an hour, or up to an entire day exploring all the Rock Hall''s exhibits. Right here in Cleveland, Ohio, you will find the only museum devoted to the story of rock and roll! Photos and video encouraged!', 41.508550, -81.695430, '1100 Rock And Roll Blvd', 'Rock Hall.png', '(216) 781-7625', 5, 'https://www.rockhall.com/', 'https://www.google.com/maps/dir//Rock+%26+Roll+Hall+of+Fame+%26+Museum,+East+9th+Street,+Cleveland,+OH/@41.5086487,-81.7654082,12z/data=!3m2!4b1!5s0x8830f08372853671:0x97828889072890f0!4m9!4m8!1m0!1m5!1m1!1s0x8830f0830dc7921d:0x971b9d1e295a165f!2m2!1d-81.6953685!2d41.5085414!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('Cleveland History Center', 'Museum of Cleveland', 'Experience Cleveland like never before at the Cleveland History Center, headquarters for the Western Reserve Historical Society (WRHS).', 41.513900, -81.610330, '10825 East Blvd', 'Cleveland History Center.jpg', '(216) 721-5722', 2, 'https://www.wrhs.org/', 'https://www.google.com/maps/dir//Cleveland+History+Center,+East+Boulevard,+Cleveland,+OH/@41.5131357,-81.6816637,12z/data=!3m2!4b1!5s0x8830f08372853671:0x97828889072890f0!4m9!4m8!1m0!1m5!1m1!1s0x8830fb8cc7c708b5:0x8eb80402d978c648!2m2!1d-81.611624!2d41.5130284!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('Terminal Tower', 'Cleveland''s Signature landmark', 'Terminal Tower is a 52-story, 235 m, landmark skyscraper located on Public Square in downtown Cleveland, Ohio, United States. Built during the skyscraper boom of the 1920s and 1930s, it was the second-tallest building in the world when it was completed. Terminal Tower stood as the tallest building in North America outside of New York City from its completion in 1930 until 1964. It was the tallest building in the state of Ohio until the completion of Key Tower in 1991, and remains the second-tallest building in the state. The building is part of the Tower City Center mixed-use development, and its major tenants include Forest City Enterprises, former owner of the building, which maintained its corporate headquarters there until 2018, and Riverside Company.', 41.500100, -81.694650, '50 Public Sq', 'Terminal Tower.jpg', '(216) 621-6060', 1, '', 'https://www.google.com/maps/dir//Terminal+Tower,+Public+Square,+Cleveland,+OH/@41.4983472,-81.7661098,12z/data=!3m2!4b1!5s0x8830f08372853671:0x97828889072890f0!4m9!4m8!1m0!1m5!1m1!1s0x8830f1d93a687ed5:0xfedfe4c5dcb4d6c6!2m2!1d-81.6960701!2d41.4982399!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('Steamship William G. Mather Maritime Museum', 'Great Lakes Bulk Freighter Museum', 'The Steamship William G. Mather is a retired Great Lakes bulk freighter now restored as a museum ship in Cleveland, Ohio, one of four in the Great Lakes region. She transported cargo such as ore, coal, stone, and grain to ports throughout the Great Lakes, and was nicknamed "The Ship That Built Cleveland" because Cleveland''s steel mills were a frequent destination.', 41.509180,  -81.694700, '1001 E 9th St, North Coast Harbor Park', 'Steamship William G Mather.jpg', '(216) 574-6262', 1, '', 'https://www.google.com/maps/dir//Steamship+William+G.+Mather+Museum,+Erieside+Avenue,+Cleveland,+OH/@41.50936,-81.7680847,12z/data=!3m2!4b1!5s0x8830f08372853671:0x97828889072890f0!4m9!4m8!1m0!1m5!1m1!1s0x8830f084ead8170d:0xaa48b0f38f95c4b4!2m2!1d-81.698045!2d41.5092527!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('Soldiers and Sailors Monument', 'Civil War Memorial', 'The Cuyahoga County Soldiers'' and Sailors Monument is a monument to Civil War soldiers and sailors from Cleveland and Cuyahoga County, Ohio. Located in the southeast quadrant of Public Square in Downtown Cleveland, it opened July 4, 1894. It was designed by architect Levi Scofield, who also created the monument''s sculptures. F.F. Schnitzer was the supervising architect who oversaw the creation of the structure. The monument is regularly open to the public free of charge.', 41.499750, -81.692530, '3 Public Sq', 'soldiers and sailors.jpg', '(216) 621-3710', 0, 'http://www.soldiersandsailors.com/', 'https://www.google.com/maps/dir//Soldiers''+and+Sailors''+Monument,+Public+Square,+Cleveland,+OH/@41.4996413,-81.7629172,12z/data=!3m2!4b1!5s0x8830f08372853671:0x97828889072890f0!4m9!4m8!1m0!1m5!1m1!1s0x8830f07fc414ae5f:0x72003419eec3020!2m2!1d-81.6928775!2d41.499534!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('Playhouse Square', 'Outdoor Chandelier', 'An exciting and entertaining destination! Utilizing the arts to engage individuals and attract more than one million guests per year to its 1,000+ annual events.', 41.500670, -81.680910, '1501 Euclid Ave Ste 200', 'Playhouse Square.jpg', '(216) 771-4444', 0, 'https://theatrecleveland.com/', 'https://www.google.com/maps/dir//Playhouse+Square,+Euclid+Avenue+%23200,+Cleveland,+OH/@41.5014121,-81.7508344,12z/data=!3m2!4b1!5s0x8830f08372853671:0x97828889072890f0!4m9!4m8!1m0!1m5!1m1!1s0x8830fa7d31bc7e1d:0xd4fedf1ad239019!2m2!1d-81.6807947!2d41.5013048!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('USS Cod Submarine', 'WWII Submarine Museum', 'USS Cod is a Gato-class submarine, the only vessel of the United States Navy to be named for the cod, the world''s most important food fish of the North Atlantic and North Pacific. Her keel was laid down by the Electric Boat Company of Groton, Connecticut on 21 July 1942. The submarine''s five diesel engines were built by General Motors'' Cleveland Diesel plant located on the west side of Cleveland. She was launched on 21 March 1943, and commissioned on 21 June 1943 with Commander James C. Dempsey in command.', 41.510950, -81.688040, '1201 N Marginal Rd', 'uss cod submarine memorial.jpg', ' 1201 N Marginal Rd', 2, 'http://usscod.org/', 'https://www.google.com/maps/dir//USS+Cod+Submarine+Memorial,+North+Marginal+Road,+Cleveland,+OH/@41.5101723,-81.7615967,12z/data=!3m2!4b1!5s0x8830f08372853671:0x97828889072890f0!4m9!4m8!1m0!1m5!1m1!1s0x8830f0832a975e43:0x1995469a50b9916b!2m2!1d-81.691557!2d41.510065!3e2')
INSERT location (Name, ShortDesc, LongDesc, Latitude, Longitude, Address, Image, PhoneNum, PriceLevel, WebsiteURL, GoogleURL) VALUES ('Federal Reserve Bank of Cleveland', 'Money Museum', 'The Federal Reserve Bank of Cleveland is the Cleveland-based headquarters of the U.S. Federal Reserve System''s Fourth District. The district is composed of Ohio, western Pennsylvania, eastern Kentucky, and the northern panhandle of West Virginia. It has branch offices in Cincinnati and Pittsburgh. The check processing center in Columbus, Ohio, was closed in 2005.', 41.502050, -81.690270, '1455 E 6th St', 'Federal Reserve bank.jpg', '(216) 579-2000', 0, 'https://www.clevelandfed.org/', 'https://www.google.com/maps/dir//Federal+Reserve+Bank+of+Cleveland,+East+6th+Street,+Cleveland,+OH/@41.5020834,-81.7602933,12z/data=!3m2!4b1!5s0x8830f08372853671:0x97828889072890f0!4m9!4m8!1m0!1m5!1m1!1s0x8830fa7f8e31665f:0xdf16e96ece7e3c66!2m2!1d-81.6902536!2d41.5019761!3e2')

INSERT location_category (Location_Id, Category_Id) VALUES (1, 1)
INSERT location_category (Location_Id, Category_Id) VALUES (2, 1)
INSERT location_category (Location_Id, Category_Id) VALUES (3, 2)
INSERT location_category (Location_Id, Category_Id) VALUES (3, 3)
INSERT location_category (Location_Id, Category_Id) VALUES (4, 1)
INSERT location_category (Location_Id, Category_Id) VALUES (5, 3)
INSERT location_category (Location_Id, Category_Id) VALUES (6, 4)
INSERT location_category (Location_Id, Category_Id) VALUES (6, 5)
INSERT location_category (Location_Id, Category_Id) VALUES (7, 6)
INSERT location_category (Location_Id, Category_Id) VALUES (7, 5)
INSERT location_category (Location_Id, Category_Id) VALUES (8, 7)
INSERT location_category (Location_Id, Category_Id) VALUES (8, 8)
INSERT location_category (Location_Id, Category_Id) VALUES (9, 1)
INSERT location_category (Location_Id, Category_Id) VALUES (10, 1)
INSERT location_category (Location_Id, Category_Id) VALUES (11, 9)
INSERT location_category (Location_Id, Category_Id) VALUES (12, 1)
INSERT location_category (Location_Id, Category_Id) VALUES (12, 8)
INSERT location_category (Location_Id, Category_Id) VALUES (13, 10)
INSERT location_category (Location_Id, Category_Id) VALUES (13, 7)
INSERT location_category (Location_Id, Category_Id) VALUES (14, 11)
INSERT location_category (Location_Id, Category_Id) VALUES (15, 1)
INSERT location_category (Location_Id, Category_Id) VALUES (15, 8)
INSERT location_category (Location_Id, Category_Id) VALUES (15, 7)
INSERT location_category (Location_Id, Category_Id) VALUES (16, 9)
INSERT location_category (Location_Id, Category_Id) VALUES (16, 8)
