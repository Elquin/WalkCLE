using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using SampleApi.Models;

namespace SampleApi.DAL
{
    public class CheckinSqlDAO : ICheckinDAO
    {
        private readonly string connectionString;

        public CheckinSqlDAO(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public bool StoreCheckin(Checkin checkin)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sql = $"INSERT INTO CheckIn (UserId, LocationId, CheckInDate) VALUES (@userId, @locationId, @checkInDate);";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@userId", checkin.UserId);
                    cmd.Parameters.AddWithValue("@locationId", checkin.LocationId);
                    cmd.Parameters.AddWithValue("@checkInDate", DateTime.Now);
                    cmd.ExecuteScalar();
                    return true;
                }
            }
            catch (SqlException ex)
            {
                return false;
            }
        }

        public List<string> GetCheckinHistory(int id)
        {
            List<string> result = new List<string>();
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string getCheckinHistory = @"select location.Name, checkin.CheckInDate from checkin
join location on checkin.LocationId = Location.Id
where checkin.UserId = @userId";

                    SqlCommand cmd = new SqlCommand(getCheckinHistory, connection);
                    cmd.Parameters.AddWithValue("@userId", id);
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string checkinDate = Convert.ToString(reader["CheckInDate"]);
                        checkinDate = checkinDate.Replace("12:00:00 AM", "");
                        //int timeIndex = checkinDate.IndexOf("12:00") - 11;
                        //checkinDate = checkinDate.Substring(0, timeIndex);
                        result.Add(Convert.ToString(reader["Name"]) + " " + checkinDate);
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
