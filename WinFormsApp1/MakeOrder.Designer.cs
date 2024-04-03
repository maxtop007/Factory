namespace WinFormsApp1
{
    partial class MakeOrder
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            dataGridView1 = new DataGridView();
            textbox_count = new MaskedTextBox();
            nomenclatureComboBox = new ComboBox();
            addNomenclatureButton = new Button();
            orderTimePicker = new DateTimePicker();
            checkEndDateButton = new Button();
            makeOrderButton = new Button();
            button1 = new Button();
            groupBox1 = new GroupBox();
            groupBox2 = new GroupBox();
            ((System.ComponentModel.ISupportInitialize)dataGridView1).BeginInit();
            groupBox1.SuspendLayout();
            groupBox2.SuspendLayout();
            SuspendLayout();
            // 
            // dataGridView1
            // 
            dataGridView1.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView1.Location = new Point(323, 82);
            dataGridView1.Name = "dataGridView1";
            dataGridView1.Size = new Size(247, 321);
            dataGridView1.TabIndex = 0;
            dataGridView1.CellContentClick += dataGridView1_CellContentClick;
            // 
            // textbox_count
            // 
            textbox_count.Location = new Point(195, 72);
            textbox_count.Mask = "000";
            textbox_count.Name = "textbox_count";
            textbox_count.Size = new Size(28, 23);
            textbox_count.TabIndex = 1;
            // 
            // nomenclatureComboBox
            // 
            nomenclatureComboBox.DropDownStyle = ComboBoxStyle.DropDownList;
            nomenclatureComboBox.FormattingEnabled = true;
            nomenclatureComboBox.Location = new Point(11, 72);
            nomenclatureComboBox.Name = "nomenclatureComboBox";
            nomenclatureComboBox.Size = new Size(121, 23);
            nomenclatureComboBox.TabIndex = 2;
            // 
            // addNomenclatureButton
            // 
            addNomenclatureButton.Location = new Point(87, 143);
            addNomenclatureButton.Name = "addNomenclatureButton";
            addNomenclatureButton.Size = new Size(124, 23);
            addNomenclatureButton.TabIndex = 3;
            addNomenclatureButton.Text = "add nomenclature";
            addNomenclatureButton.UseVisualStyleBackColor = true;
            addNomenclatureButton.Click += addNomenclatureButton_Click;
            // 
            // orderTimePicker
            // 
            orderTimePicker.Location = new Point(38, 28);
            orderTimePicker.Name = "orderTimePicker";
            orderTimePicker.Size = new Size(200, 23);
            orderTimePicker.TabIndex = 4;
            // 
            // checkEndDateButton
            // 
            checkEndDateButton.Location = new Point(38, 83);
            checkEndDateButton.Name = "checkEndDateButton";
            checkEndDateButton.Size = new Size(103, 24);
            checkEndDateButton.TabIndex = 5;
            checkEndDateButton.Text = "check end date";
            checkEndDateButton.UseVisualStyleBackColor = true;
            checkEndDateButton.Click += checkEndDateButton_Click;
            // 
            // makeOrderButton
            // 
            makeOrderButton.Location = new Point(163, 83);
            makeOrderButton.Name = "makeOrderButton";
            makeOrderButton.Size = new Size(75, 23);
            makeOrderButton.TabIndex = 6;
            makeOrderButton.Text = "make order";
            makeOrderButton.UseVisualStyleBackColor = true;
            makeOrderButton.Click += makeOrderButton_Click_1;
            // 
            // button1
            // 
            button1.Location = new Point(86, 128);
            button1.Name = "button1";
            button1.Size = new Size(113, 24);
            button1.TabIndex = 7;
            button1.Text = "All info";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click;
            // 
            // groupBox1
            // 
            groupBox1.Controls.Add(addNomenclatureButton);
            groupBox1.Controls.Add(nomenclatureComboBox);
            groupBox1.Controls.Add(textbox_count);
            groupBox1.Location = new Point(3, 71);
            groupBox1.Name = "groupBox1";
            groupBox1.Size = new Size(286, 174);
            groupBox1.TabIndex = 8;
            groupBox1.TabStop = false;
            groupBox1.Text = "Add Nomenclature to order";
            groupBox1.Enter += groupBox1_Enter;
            // 
            // groupBox2
            // 
            groupBox2.Controls.Add(button1);
            groupBox2.Controls.Add(makeOrderButton);
            groupBox2.Controls.Add(checkEndDateButton);
            groupBox2.Controls.Add(orderTimePicker);
            groupBox2.Location = new Point(3, 251);
            groupBox2.Name = "groupBox2";
            groupBox2.Size = new Size(286, 165);
            groupBox2.TabIndex = 9;
            groupBox2.TabStop = false;
            groupBox2.Text = "Make Order";
            // 
            // MakeOrder
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(603, 486);
            Controls.Add(groupBox2);
            Controls.Add(groupBox1);
            Controls.Add(dataGridView1);
            Name = "MakeOrder";
            Text = "MakeOrder";
            Load += MakeOrder_Load;
            ((System.ComponentModel.ISupportInitialize)dataGridView1).EndInit();
            groupBox1.ResumeLayout(false);
            groupBox1.PerformLayout();
            groupBox2.ResumeLayout(false);
            ResumeLayout(false);
        }

        #endregion

        private DataGridView dataGridView1;
        private MaskedTextBox textbox_count;
        private ComboBox nomenclatureComboBox;
        private Button addNomenclatureButton;
        private DateTimePicker orderTimePicker;
        private Button checkEndDateButton;
        private Button makeOrderButton;
        private Button button1;
        private GroupBox groupBox1;
        private GroupBox groupBox2;
    }
}