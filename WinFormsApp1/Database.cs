using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data.SqlClient;
using System.Data;
using System.Windows.Forms;



namespace WinFormsApp1
{
    class Database
    {
        private string connectionString;
        string server="localhost";
        //string server = "";

        string database ="FACTORY";

        public Database(string username, string password)
        {
            connectionString = $"Server={server};Database={database};User ID={username};Password={password}";
        }

        public bool CheckConnection()
        {
            try
            {
                using (SqlConnection connection = GetConnection())
                {
                    connection.Open();
                    connection.Close();
                }
                return true;
            }
            catch (SqlException ex)
            {
                MessageBox.Show("An error occurred while connecting to the database: " + ex.Message);
                return false;
            }
        }

        public void InputDatatoDatagridView(DataGridView datagridview, string query)
        {
            using (DataTable table = new DataTable())
            {
                using (SqlConnection connection = GetConnection())
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            try
                            {
                                adapter.Fill(table);
                            }

                            catch (SqlException ex)
                            {
                                MessageBox.Show("Error in data " + ex.Message);
                            }
                            
                        }
                    }


                    connection.Close();
                }
                if  (table.Rows.Count > 0)
                    datagridview.DataSource = table;
                else 
                    MessageBox.Show("No data retrieved from the database.");
            }
        }


        public void InsertDatatoComboBox(ComboBox combobox, string query)
        {
            using (DataTable table = new DataTable())
            {

                using (SqlConnection connection = GetConnection())
                {
                    connection.Open();

                   
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        adapter.Fill(table);
                    }

                    connection.Close();
                }

                if (table.Rows.Count > 0)
                {

                    combobox.DataSource = table.DefaultView.ToTable(true, "ID", "Name");
                    combobox.DisplayMember = "Name";
                    combobox.ValueMember = "ID";

                }
                else
                {
                    MessageBox.Show("No data retrieved from the database.");
                }
            }

        }


        public DataTable InsertDatatoComboBox(string query)
        {
            using (DataTable table = new DataTable())
            {

                using (SqlConnection connection = GetConnection())
                {
                    connection.Open();


                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        adapter.Fill(table);
                    }

                    connection.Close();
                }

                return table;
            }

        }

        public SqlConnection GetConnection()
        {
            return new SqlConnection(connectionString);
        }
    }
}
