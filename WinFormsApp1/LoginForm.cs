using System.Data.SqlClient;
using System.Data.Common;
namespace WinFormsApp1

{
    public partial class LoginForm : Form
    {





        public LoginForm()
        {
            InitializeComponent();
        }

        private void LoginForm_Load(object sender, EventArgs e)
        {

        }

        private void flowLayoutPanel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {



            Database database = new Database(textBox_login.Text, textBox_password.Text);

            bool connectflag;


            connectflag = database.CheckConnection();
            if (connectflag)
            {
                MessageBox.Show("Connection established");

                MakeOrder makeOrder = new MakeOrder();
                makeOrder.Show();
                makeOrder.IninitializeData(textBox_login.Text, textBox_password.Text);
                this.Hide();

                makeOrder.FormClosed += (s, args) => this.Close();
            }
            else
            {
                MessageBox.Show("Connection failed");
            }

            textBox_login.Text = "";
            textBox_password.Text = "";
            
            
            
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {

            if (checkBox1.Checked)
            {
                textBox_password.PasswordChar = '\0';
            }
            else
            {
                textBox_password.PasswordChar = '•';
            }
        }
    }

}
