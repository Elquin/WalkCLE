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
        private readonly string connectionString;

        /// <summary>
        /// Creates a new sql dao for Location objects.
        /// </summary>
        /// <param name="connectionString">the database connection string</param>
        public LocationSqlDAO(string connectionString)
        {
            this.connectionString = connectionString;
        }

        /// <summary>
        /// Creates a list of locations in the database.
        /// </summary>
        public List<Location> GetAllLocations()
        {
            List<Location> locationList = new List<Location>();
            string allLocationsSql = @"SELECT * from Location";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    SqlCommand cmd = new SqlCommand(allLocationsSql, connection);
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        locationList.Add(MapRowToLocation(reader));
                    }
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }

            // mapping the multiple categories to a single location
            try
            {
                foreach (Location location in locationList)
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();

                        string getCategoriesSql = @"select *, Category.Name as 'category_name' from Location
join Location_Category on Location_Category.Location_Id = Location.Id
join Category on Location_Category.Category_Id = Category.Id
where Location.Name = @locationName";

                        SqlCommand cmd = new SqlCommand(getCategoriesSql, connection);
                        cmd.Parameters.AddWithValue("@locationName", location.Name);
                        location.Categories = new List<string>();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            location.Categories.Add(Convert.ToString(reader["category_name"]));
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }

            return locationList;
        }

        /// <summary>
        /// Generates details of a location
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Location GetLocation(int id)
        {
            Location location = new Location();
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlCommand cmd = new SqlCommand(@"SELECT * FROM Location WHERE Id = @locationId;", connection);
                    cmd.Parameters.AddWithValue("@locationId", id);

                    SqlDataReader reader = cmd.ExecuteReader();
                    reader.Read();
                    location =  MapRowToLocation(reader);
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }

            // mapping the multiple categories to a single location
            try
            {
                
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string getCategoriesSql = @"select *, Category.Name as 'category_name' from Location
join Location_Category on Location_Category.Location_Id = Location.Id
join Category on Location_Category.Category_Id = Category.Id
where Location.Name = @locationName";

                    SqlCommand cmd = new SqlCommand(getCategoriesSql, connection);
                    cmd.Parameters.AddWithValue("@locationName", location.Name);
                    location.Categories = new List<string>();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        location.Categories.Add(Convert.ToString(reader["category_name"]));
                    }
                }
                
            }
            catch (SqlException ex)
            {
                throw ex;
            }

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
                Latitude = Convert.ToDecimal(reader["Latitude"]),
                Longitude = Convert.ToDecimal(reader["Longitude"]),
                Address = Convert.ToString(reader["Address"]),
                Image = Convert.ToString(reader["Image"]),
                PhoneNumber = Convert.ToString(reader["PhoneNum"]),
                PriceLevel = Convert.ToInt32(reader["PriceLevel"]),
                WebsiteURL = Convert.ToString(reader["WebsiteURL"]),
            };
        }
    }
}
