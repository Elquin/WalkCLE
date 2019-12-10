-- Remove all the data from the DB

DELETE FROM Location;

-- insert some test data

-- Location
INSERT INTO Location (
	   [Name]
      ,[ShortDesc]
      ,[LongDesc]
      ,[Latitude]
      ,[Longitude]
      ,[Address]
      ,[Image]
      ,[PhoneNum]
      ,[PriceLevel]
      ,[WebsiteURL])
	  VALUES ('Test Location', 'Test Short Description', 'Test Long Description', 12.123456, -98,765432, '1 Main Street Rd', '', 1, 'https://www.test.com');
