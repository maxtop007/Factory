namespace WinFormsApp1
{
    partial class LoginForm
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            panel1 = new Panel();
            textBox_password = new TextBox();
            label2 = new Label();
            label1 = new Label();
            textBox_login = new TextBox();
            button1 = new Button();
            checkBox1 = new CheckBox();
            panel1.SuspendLayout();
            SuspendLayout();
            // 
            // panel1
            // 
            panel1.AutoSize = true;
            panel1.Controls.Add(checkBox1);
            panel1.Controls.Add(textBox_password);
            panel1.Controls.Add(label2);
            panel1.Controls.Add(label1);
            panel1.Controls.Add(textBox_login);
            panel1.Controls.Add(button1);
            panel1.Location = new Point(65, 30);
            panel1.Name = "panel1";
            panel1.Size = new Size(375, 171);
            panel1.TabIndex = 0;
            // 
            // textBox_password
            // 
            textBox_password.Location = new Point(135, 66);
            textBox_password.MaxLength = 255;
            textBox_password.Name = "textBox_password";
            textBox_password.PasswordChar = '•';
            textBox_password.Size = new Size(133, 23);
            textBox_password.TabIndex = 4;
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(44, 74);
            label2.Name = "label2";
            label2.Size = new Size(57, 15);
            label2.TabIndex = 3;
            label2.Text = "password";
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(44, 34);
            label1.Name = "label1";
            label1.Size = new Size(34, 15);
            label1.TabIndex = 1;
            label1.Text = "login";
            // 
            // textBox_login
            // 
            textBox_login.Location = new Point(135, 31);
            textBox_login.MaxLength = 255;
            textBox_login.Name = "textBox_login";
            textBox_login.Size = new Size(133, 23);
            textBox_login.TabIndex = 2;
            // 
            // button1
            // 
            button1.Location = new Point(135, 132);
            button1.Name = "button1";
            button1.Size = new Size(75, 23);
            button1.TabIndex = 0;
            button1.Text = "sign in";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click;
            // 
            // checkBox1
            // 
            checkBox1.AutoSize = true;
            checkBox1.Location = new Point(136, 97);
            checkBox1.Name = "checkBox1";
            checkBox1.Size = new Size(101, 19);
            checkBox1.TabIndex = 5;
            checkBox1.Text = "show symbols";
            checkBox1.UseVisualStyleBackColor = true;
            checkBox1.CheckedChanged += checkBox1_CheckedChanged;
            // 
            // LoginForm
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(479, 224);
            Controls.Add(panel1);
            Name = "LoginForm";
            Text = "Login";
            Load += LoginForm_Load;
            panel1.ResumeLayout(false);
            panel1.PerformLayout();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Panel panel1;
        private TextBox textBox_login;
        private Label label1;
        private Button button1;
        private TextBox textBox_password;
        private Label label2;
        private CheckBox checkBox1;
    }
}
