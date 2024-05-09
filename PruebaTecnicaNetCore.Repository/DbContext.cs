﻿using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Data;

namespace PruebaTecnicaNetCore.Repository
{
    public class DbContext
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public DbContext(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("DbConn");
        }

        public IDbConnection CreateConnection()
        {
            IDbConnection conn;

            try
            {
                conn = new SqlConnection(_connectionString);
                conn.Open();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error connecting to the database: {ex.Message}");
                throw;
            }

            return conn;
        }
    }
}