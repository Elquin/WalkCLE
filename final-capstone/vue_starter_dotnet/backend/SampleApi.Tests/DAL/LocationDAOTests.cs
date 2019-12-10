using Microsoft.VisualStudio.TestTools.UnitTesting;
using SampleApi.DAL;
using SampleApi.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Transactions;

namespace SampleApi.Tests.DAL
{
    [TestClass]
    public class LocationDAOTests
    {
        private TransactionScope transaction;
        const string connectionString = "Server=.\\SQLEXPRESS;Initial Catalog=WalkCLE;Integrated Security=True";
        
        [TestInitialize]
        public void Setup()
        {
            // Begin a transaction
            this.transaction = new TransactionScope();
            string script;
            // Load a script file to setup the db the way we want it
            using (StreamReader sr = new StreamReader("../../../DAL/test_setup.sql"))
            {
                script = sr.ReadToEnd();
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(script, conn);

                SqlDataReader rdr = cmd.ExecuteReader();
            }
        }

        [TestCleanup]
        public void Cleanup()
        {
            // Roll back the transaction
            this.transaction.Dispose();
        }

        [TestMethod]
        public void Return_List_Result_1_Item()
        {
            //Arrange
            LocationSqlDAO dao = new LocationSqlDAO(connectionString);

            //Act
            List<Location> list = dao.GetAllLocations();

            //Assert
            Assert.AreEqual(1, list.Count);
        }

        [TestMethod]
        public void Return_One_Location_Details()
        {
            //Arrange
            LocationSqlDAO dao = new LocationSqlDAO(connectionString);

            //Act
            Location test = dao.GetLocation(1);
            string actualResult = test.Name;

            //Assert
            Assert.AreEqual(actualResult, "Test Location");


        }



    }
}
