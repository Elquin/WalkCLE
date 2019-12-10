using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using SampleApi.Models;

namespace SampleApi.DAL
{
    public class LocationSqlDAO : ILocationDAO
    {
        public List<Location> GetAllLocations()
        {
            List<Location> locationList = new List<Location>();


            return locationList;
        }

        public Location GetLocation()
        {
            Location location = new Location();


            return location;
        }



        private Location MapRowToLocation(SqlDataReader reader)
        {
            return new Location()
            {
                Id = Convert.ToInt32(reader["Id"]),
                Name = Convert.ToString(reader["Name"]),
                ShortDescription = Convert.ToString(reader["ShortDesc"]),
                LongDescription = Convert.ToString(reader["LongDesc"]),
                Latitude = Convert.ToInt32(reader["Latitude"]),
                Longitude = Convert.ToInt32(reader["Longitude"]),
                Category = Convert.ToString(reader["Category"]),
                Address = Convert.ToString(reader["Address"]),
                Image = Convert.ToString(reader["Image"]),
                PhoneNumber = Convert.ToString(reader["PhoneNum"]),
                PriceLevel = Convert.ToInt32(reader["PriceLevel"]),
                WebsiteURL = Convert.ToString(reader["WebsiteURL"]),
            };
        }
    }
}
