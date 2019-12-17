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
    }
}
