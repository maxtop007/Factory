using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace WinFormsApp1
{
    public partial class MakeOrder : Form
    {
        string login;
        string password;
        public MakeOrder()
        {
            InitializeComponent();


        }

        public void IninitializeData(string i_login, string i_password)
        {
            login = i_login;
            password = i_password;

            dataGridView1.ReadOnly = true;
            orderTimePicker.MinDate = DateTime.Now;

            Database database = new Database(login, password);

            using (DataTable table = new DataTable())
            {

                using (SqlConnection connection = database.GetConnection())
                {
                    connection.Open();

                    string query = "select N.ID, N.Name  from dbo.Nomenclatures as N;";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        adapter.Fill(table);
                    }

                    connection.Close();
                }

                if (table.Rows.Count > 0)
                {

                    nomenclatureComboBox.DataSource = table.DefaultView.ToTable(true, "ID", "Name");
                    nomenclatureComboBox.DisplayMember = "Name";
                    nomenclatureComboBox.ValueMember = "ID";
                    dataGridView1.Columns.Add("Name", "Nomenclature name");
                    dataGridView1.Columns.Add("Count", "Count");
                }
                else
                {
                    MessageBox.Show("No data retrieved from the database.");
                }

            }
        }

        private void MakeOrder_Load(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void addNomenclatureButton_Click(object sender, EventArgs e)
        {
            string selectedText = nomenclatureComboBox.Text;


            int count;

            if (int.TryParse(textbox_count.Text, out count))
            {
                if ((!string.IsNullOrEmpty(selectedText)) && (int.Parse(textbox_count.Text) > 0))
                {
                    DataGridViewRow existingRow = (DataGridViewRow)dataGridView1.Rows
                        .Cast<DataGridViewRow>()
                        .FirstOrDefault(row => row.Cells["Name"].Value != null && row.Cells["Name"].Value.ToString() == selectedText);
                    if (existingRow != null)
                    {
                        int existingCount;

                        if (int.TryParse(existingRow.Cells["Count"].Value.ToString(), out existingCount))
                        {
                            existingRow.Cells["Count"].Value = existingCount + count;
                        }

                    }
                    else
                        dataGridView1.Rows.Add(selectedText, count);
                }
                else
                    MessageBox.Show("Wrong Data");
            }
            else
                MessageBox.Show("Wrong Data");



        }

        private DataTable GetTable()
        {
            DataTable datatable = new DataTable();

            datatable.Columns.Add("NomenclatureName", typeof(string));
            datatable.Columns.Add("NomenclatureCount", typeof(int));

            var rows = dataGridView1.Rows.Cast<DataGridViewRow>().Where(row => row.Cells["Name"].Value != null);

            foreach (DataGridViewRow row in rows)
            {
                DataRow dataRow = datatable.NewRow();
                dataRow["NomenclatureName"] = row.Cells["Name"].Value.ToString();
                dataRow["NomenclatureCount"] = int.Parse(row.Cells["Count"].Value.ToString());
                datatable.Rows.Add(dataRow);
            }
            return datatable;
        }

        private SqlCommand PrepareCommand(string procedureName, SqlConnection connection)
        {
            SqlCommand command = new SqlCommand(procedureName, connection);
            command.CommandType = CommandType.StoredProcedure;

            DataTable dataTable = GetTable();
            SqlParameter parameter = new SqlParameter("@InsertNomenclature", SqlDbType.Structured);
            parameter.TypeName = "dbo.NomenclatureListType";
            parameter.Value = dataTable;
            command.Parameters.Add(parameter);


            command.Parameters.Add("@EndDate", SqlDbType.DateTime).Value = orderTimePicker.Value;

            return command;
        }

        private bool CheckDate()
        {
            Database database = new Database(login, password);

            bool result_flag = false;

            using (SqlConnection connection = database.GetConnection())
            {
                connection.Open();
                SqlCommand command = PrepareCommand("dbo.usp_CHK_EndDate", connection);


                var result = command.Parameters.Add("@Result", SqlDbType.Bit);
                result.Direction = ParameterDirection.ReturnValue;

                try
                {
                    command.ExecuteNonQuery();
                    int resultObj = (int)result.Value;

                    if (resultObj != null)
                    {
                        if (resultObj == 1)
                        {
                            MessageBox.Show("Factory can produce this nomenclature at this time");
                            result_flag = true;
                        }
                        else
                        {
                            MessageBox.Show("Factory needs more time to produce this nomenclature");
                        }
                    }
                    else
                    {
                        // Handle the case where the result is null
                        MessageBox.Show("The result is null");
                    }
                }
                catch (InvalidCastException ex)
                {
                    MessageBox.Show("Error converting the result to int: " + ex.Message);
                }
                catch (SqlException ex)
                {
                    MessageBox.Show("An error occurred while connecting to the database: " + ex.Message);
                }






                connection.Close();

            }

            return result_flag;
        }

        private void checkEndDateButton_Click(object sender, EventArgs e)
        {
            bool result_flag = CheckDate();



        }

        private void MakeOrderVoid()
        {
            Database database = new Database(login, password);

            using (SqlConnection connection = database.GetConnection())
            {
                connection.Open();

                SqlCommand command = PrepareCommand("dbo.usp_InsertOrderWithNomenclatures", connection);
                try
                {
                    command.ExecuteNonQuery();
                }

                catch (SqlException ex)
                {
                    MessageBox.Show("An error occurred while connecting to the database: " + ex.Message);
                }
                connection.Close();

            }

        }

        private void makeOrderButton_Click(object sender, EventArgs e)
        {
            bool result_flag = CheckDate();

            if (result_flag)
            {
                MakeOrderVoid();
            }


        }

        private void makeOrderButton_Click_1(object sender, EventArgs e)
        {
            bool result_flag = CheckDate();

            if (result_flag)
            {
                MakeOrderVoid();
                MessageBox.Show("Order created successfully");
            }

        }

        private void button1_Click(object sender, EventArgs e)
        {
            WatchResultForm watchResultForm = new WatchResultForm();
            watchResultForm.Show();
            watchResultForm.InitializeData(login, password);
            this.Hide();
            watchResultForm.Closed += (s, args) => this.Show();
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }
    }
}
