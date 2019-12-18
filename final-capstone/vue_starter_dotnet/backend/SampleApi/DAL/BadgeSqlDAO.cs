using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace SampleApi.DAL
{
    public class BadgeSqlDAO : IBadgeDAO
    {
        private readonly string connectionString;

        public BadgeSqlDAO(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public List<string> GetBadges(int id)
        {
            List<string> result = new List<string>();
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string getBadges = @"select badge.Name from userbadge
join badge on userbadge.badgeid = badge.Id
where userbadge.UserId = @userId
order by CheckInDate desc";

                    SqlCommand cmd = new SqlCommand(getBadges, connection);
                    cmd.Parameters.AddWithValue("@userId", id);
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string badge = Convert.ToString(reader["Name"]);
                        result.Add(badge);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            return result;
        }
    }
}
