using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace WinFormsApp1
{
    public partial class WatchResultForm : Form
    {
        string login;
        string password;
        static string nomencltureInBuildAreaQuery = "SELECT \r\n\tBA.Name as BuildAreaName,\r\n\tN.Name as NomenclatureName,\r\n\t--SUM(CASE WHEN PN.ID_Order IS NULL THEN RN.Count ELSE 0 END) as RemainingNomenclatureCount,\r\n\t--RN.Count as RemainingNomenclatureCount,\r\n\tCOALESCE(RN.Count, 0)  as RemainingNomenclatureCount,\r\n\tSUM(PN.Count) as OrderNomenclatureCount,\r\n\tCOALESCE(RN.Count, 0) + SUM( PN.Count) as AllCount\r\nFROM dbo.ProducedNomenclature as PN\r\n\tINNER JOIN dbo.BuildAreas as BA ON PN.ID_BuildArea = BA.ID\r\n\tINNER JOIN dbo.Nomenclatures as N ON PN.ID_Nomenclature = N.ID\r\n\tLEFT JOIN dbo.RemainingNomenclature as RN ON PN.ID_BuildArea = RN.ID_BuildArea AND PN.ID_Nomenclature = RN.ID_Nomenclature\r\nGROUP BY BA.Name, N.Name,COALESCE(RN.Count, 0) \r\n\r\nUNION\r\n\r\nSELECT \r\n\tBA.Name as BuildAreaName,\r\n\tN.Name as NomenclatureName,\r\n\tRN.Count as RemainingNomenclatureCount,\r\n\t0 as OrderNomenclatureCount,\r\n\tRN.Count as AllCount\r\nFROM dbo.RemainingNomenclature as RN\r\n\tINNER JOIN dbo.BuildAreas as BA ON RN.ID_BuildArea = BA.ID\r\n\tINNER JOIN dbo.Nomenclatures as N ON RN.ID_Nomenclature = N.ID\r\nWHERE NOT EXISTS (\r\n\tSELECT 1\r\n\tFROM dbo.ProducedNomenclature as PN\r\n\tWHERE PN.ID_BuildArea = RN.ID_BuildArea AND PN.ID_Nomenclature = RN.ID_Nomenclature\r\n)";
        static string remainingNomenclaturesQuery = "select \r\n\tN.Name\r\n\t,sum(RN.Count) as RemainingCount\r\nfrom dbo.RemainingNomenclature as RN\r\n\tinner join dbo.Nomenclatures as N on RN.ID_Nomenclature=N.ID\r\ngroup by N.Name\r\norder by sum(RN.Count);\r\n";
        static string remainingNomenclatureCountQuery = "select\r\n\tsum(RN.Count) as AllRemainingCount\r\nfrom dbo.RemainingNomenclature as RN;";
        static string buildAreaQuery = "select \r\n\tBA.ID\r\n\t,BA.Name\r\nfrom dbo.BuildAreas as BA\r\norder by BA.Name;";
        static string orderQuery = "select \r\n\tO.ID\r\n\t,O.Number\r\nfrom dbo.Orders as O\r\norder by O.Number;";

        public WatchResultForm()
        {
            InitializeComponent();
            dataGridView1.ReadOnly = true;
            dataGridView2.ReadOnly = true;
            dataGridView3.ReadOnly = true;
        }

        public void InitializeData(string i_login, string i_password)
        {
            login = i_login;
            password = i_password;
            Database database = new Database(login, password);
            DataGridView dataGridView = tabControl1.TabPages[0].Controls.OfType<DataGridView>().First();
            database.InputDatatoDatagridView(dataGridView, nomencltureInBuildAreaQuery);
            using (DataTable table = database.InsertDatatoComboBox(buildAreaQuery))
            {
                if (table.Rows.Count > 0)
                {

                    buildAreaComboBox.DataSource = table.DefaultView.ToTable(true, "ID", "Name");
                    buildAreaComboBox.DisplayMember = "Name";
                    buildAreaComboBox.ValueMember = "ID";

                }
                else
                {
                    MessageBox.Show("No data retrieved from the database.");
                }
            }

        }

        private void tabPage2_Click(object sender, EventArgs e)
        {
            Database database = new Database(login, password);

            database.InputDatatoDatagridView(dataGridView2, remainingNomenclaturesQuery);
        }

        private void tabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Database database = new Database(login, password);

            switch (tabControl1.SelectedIndex)
            {
                case 0:
                    database.InputDatatoDatagridView(dataGridView1, nomencltureInBuildAreaQuery);
                    break;
                case 1:
                    database.InputDatatoDatagridView(dataGridView2, remainingNomenclaturesQuery);
                    using (SqlConnection connection = database.GetConnection())
                    {
                        connection.Open();
                        using (SqlCommand command = new SqlCommand(remainingNomenclatureCountQuery, connection))
                        {
                            using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                            {
                                RemainingNomLabel.Text = adapter.SelectCommand.ExecuteScalar().ToString();
                            }
                        }
                    }
                    break;
                case 2:


                    break;
                case 3:
                    using (DataTable orderTable = database.InsertDatatoComboBox(orderQuery))
                    {
                        if (orderTable.Rows.Count > 0)
                        {
                            ordersComboBox.DataSource = orderTable.DefaultView.ToTable(true, "ID", "Number");
                            ordersComboBox.DisplayMember = "Number";
                            ordersComboBox.ValueMember = "ID";
                        }
                        else
                        {
                            MessageBox.Show("No data retrieved from the database.");
                        }
                    }
                    break;
            }
        }

        private void UpdateDataGridView(string text, DataGridView datagridview, string query)
        {
            string name = text;

            if (!string.IsNullOrWhiteSpace(name) && name != "System.Data.DataRowView")
            {


                Database database = new Database(login, password);
                database.InputDatatoDatagridView(datagridview, query.Replace("@Name", name));
            }
        }

        private void buildAreaComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            string buildAreaName = buildAreaComboBox.Text;
            string buildQueueforBuildAreaQueue = "SELECT BA.Name AS BuildAreaName, O.Number AS OrderNumber, N.Name AS NomenclatureName, BQ.StartDate, BQ.EndDate FROM dbo.BuildQueue AS BQ INNER JOIN dbo.Orders AS O ON O.ID = BQ.ID_Order INNER JOIN dbo.Nomenclatures AS N ON N.ID = BQ.ID_Nomenclature INNER JOIN dbo.BuildAreas AS BA ON BA.ID = BQ.ID_BuildArea WHERE BA.Name = '@Name' ORDER BY BA.Name;";

            UpdateDataGridView(buildAreaName, dataGridView3, buildQueueforBuildAreaQueue);




        }

        private void ordersComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            string orderNumber = ordersComboBox.Text;
            string orderQuery = "select\r\n\tN.Name\r\n\t,OrdN.Count\r\n\t,case \r\n\t\twhen sum(PN.Count) is null\r\n\t\t\tthen 0\r\n\t\t\telse sum(PN.Count)\r\n\tend  as ProducedCount\r\n\t,case\r\n\t\twhen count (BQ.ID) is null \r\n\t\t\tthen 0\r\n\t\t\telse count (BQ.ID)\r\n\tend as NomenclatureinQueue\r\nfrom dbo.Orders_Nomenclatures as OrdN\r\n\tinner join dbo.Nomenclatures as N on OrdN.ID_Nomenclature=N.ID\r\n\tinner join dbo.Orders as O on OrdN.ID_Order=O.ID\r\n\tleft join dbo.ProducedNomenclature as PN on (OrdN.ID_Order=PN.ID_Order) and (OrdN.ID_Nomenclature=PN.ID_Nomenclature)\r\n\tleft join dbo.BuildQueue as BQ on (OrdN.ID_Order=BQ.ID_Order) and (OrdN.ID_Nomenclature=BQ.ID_Nomenclature)\r\nwhere O.Number='@Name'\r\ngroup by N.Name,OrdN.Count;";

            UpdateDataGridView(orderNumber, dataGridView4, orderQuery);
        }

        private void cancelOrderButton_Click(object sender, EventArgs e)
        {
            Database database = new Database(login, password);
            using (SqlConnection connection = database.GetConnection())
            {
                connection.Open();
                SqlCommand command = new SqlCommand("dbo.usp_CancelOrder", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@Ordernumber", SqlDbType.VarChar).Value = ordersComboBox.Text;
                try
                {
                    command.ExecuteNonQuery();
                    MessageBox.Show("Order canceled successfully");
                }
                catch (SqlException ex)
                {
                    MessageBox.Show("An error occurred  " + ex.Message);
                }
                connection.Close();
            }
            using (DataTable orderTable = database.InsertDatatoComboBox(orderQuery))
            {
                if (orderTable.Rows.Count > 0)
                {
                    ordersComboBox.DataSource = orderTable.DefaultView.ToTable(true, "ID", "Number");
                    ordersComboBox.DisplayMember = "Number";
                    ordersComboBox.ValueMember = "ID";
                }
                else
                {
                    MessageBox.Show("No data retrieved from the database.");
                }
            }
        }
    }
}
