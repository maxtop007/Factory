namespace WinFormsApp1
{
    partial class WatchResultForm
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
            tabControl1 = new TabControl();
            tabPage1 = new TabPage();
            dataGridView1 = new DataGridView();
            tabPage2 = new TabPage();
            RemainingNomLabel = new Label();
            label2 = new Label();
            dataGridView2 = new DataGridView();
            tabPage3 = new TabPage();
            buildAreaComboBox = new ComboBox();
            label3 = new Label();
            dataGridView3 = new DataGridView();
            tabPage4 = new TabPage();
            cancelOrderButton = new Button();
            ordersComboBox = new ComboBox();
            label4 = new Label();
            dataGridView4 = new DataGridView();
            tabControl1.SuspendLayout();
            tabPage1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)dataGridView1).BeginInit();
            tabPage2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)dataGridView2).BeginInit();
            tabPage3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)dataGridView3).BeginInit();
            tabPage4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)dataGridView4).BeginInit();
            SuspendLayout();
            // 
            // tabControl1
            // 
            tabControl1.Controls.Add(tabPage1);
            tabControl1.Controls.Add(tabPage2);
            tabControl1.Controls.Add(tabPage3);
            tabControl1.Controls.Add(tabPage4);
            tabControl1.Location = new Point(-2, -2);
            tabControl1.Name = "tabControl1";
            tabControl1.SelectedIndex = 0;
            tabControl1.Size = new Size(806, 453);
            tabControl1.TabIndex = 0;
            tabControl1.SelectedIndexChanged += tabControl1_SelectedIndexChanged;
            // 
            // tabPage1
            // 
            tabPage1.Controls.Add(dataGridView1);
            tabPage1.Location = new Point(4, 24);
            tabPage1.Name = "tabPage1";
            tabPage1.Padding = new Padding(3);
            tabPage1.Size = new Size(798, 425);
            tabPage1.TabIndex = 0;
            tabPage1.Text = "All produced nomenclature";
            tabPage1.UseVisualStyleBackColor = true;
            // 
            // dataGridView1
            // 
            dataGridView1.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView1.Location = new Point(10, 17);
            dataGridView1.Name = "dataGridView1";
            dataGridView1.Size = new Size(764, 322);
            dataGridView1.TabIndex = 0;
            // 
            // tabPage2
            // 
            tabPage2.Controls.Add(RemainingNomLabel);
            tabPage2.Controls.Add(label2);
            tabPage2.Controls.Add(dataGridView2);
            tabPage2.Location = new Point(4, 24);
            tabPage2.Name = "tabPage2";
            tabPage2.Padding = new Padding(3);
            tabPage2.Size = new Size(798, 425);
            tabPage2.TabIndex = 1;
            tabPage2.Text = "All Remaining nomenclature";
            tabPage2.UseVisualStyleBackColor = true;
            tabPage2.Click += tabPage2_Click;
            // 
            // RemainingNomLabel
            // 
            RemainingNomLabel.AutoSize = true;
            RemainingNomLabel.Location = new Point(235, 391);
            RemainingNomLabel.Name = "RemainingNomLabel";
            RemainingNomLabel.Size = new Size(0, 15);
            RemainingNomLabel.TabIndex = 2;
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(38, 391);
            label2.Name = "label2";
            label2.Size = new Size(181, 15);
            label2.TabIndex = 1;
            label2.Text = "Remaining nomebclature count :";
            // 
            // dataGridView2
            // 
            dataGridView2.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView2.Location = new Point(0, 0);
            dataGridView2.Name = "dataGridView2";
            dataGridView2.Size = new Size(798, 380);
            dataGridView2.TabIndex = 0;
            // 
            // tabPage3
            // 
            tabPage3.Controls.Add(buildAreaComboBox);
            tabPage3.Controls.Add(label3);
            tabPage3.Controls.Add(dataGridView3);
            tabPage3.Location = new Point(4, 24);
            tabPage3.Name = "tabPage3";
            tabPage3.Size = new Size(798, 425);
            tabPage3.TabIndex = 2;
            tabPage3.Text = "Build Queue";
            tabPage3.UseVisualStyleBackColor = true;
            // 
            // buildAreaComboBox
            // 
            buildAreaComboBox.DropDownStyle = ComboBoxStyle.DropDownList;
            buildAreaComboBox.FormattingEnabled = true;
            buildAreaComboBox.Location = new Point(125, 364);
            buildAreaComboBox.Name = "buildAreaComboBox";
            buildAreaComboBox.Size = new Size(121, 23);
            buildAreaComboBox.TabIndex = 2;
            buildAreaComboBox.SelectedIndexChanged += buildAreaComboBox_SelectedIndexChanged;
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(41, 366);
            label3.Name = "label3";
            label3.Size = new Size(66, 15);
            label3.TabIndex = 1;
            label3.Text = "Build Areas";
            // 
            // dataGridView3
            // 
            dataGridView3.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView3.Location = new Point(3, 3);
            dataGridView3.Name = "dataGridView3";
            dataGridView3.Size = new Size(792, 345);
            dataGridView3.TabIndex = 0;
            // 
            // tabPage4
            // 
            tabPage4.Controls.Add(cancelOrderButton);
            tabPage4.Controls.Add(ordersComboBox);
            tabPage4.Controls.Add(label4);
            tabPage4.Controls.Add(dataGridView4);
            tabPage4.Location = new Point(4, 24);
            tabPage4.Name = "tabPage4";
            tabPage4.Size = new Size(798, 425);
            tabPage4.TabIndex = 3;
            tabPage4.Text = "Cancel Order";
            tabPage4.UseVisualStyleBackColor = true;
            // 
            // cancelOrderButton
            // 
            cancelOrderButton.Location = new Point(301, 357);
            cancelOrderButton.Name = "cancelOrderButton";
            cancelOrderButton.Size = new Size(119, 23);
            cancelOrderButton.TabIndex = 3;
            cancelOrderButton.Text = "cancel order";
            cancelOrderButton.UseVisualStyleBackColor = true;
            cancelOrderButton.Click += cancelOrderButton_Click;
            // 
            // ordersComboBox
            // 
            ordersComboBox.DropDownStyle = ComboBoxStyle.DropDownList;
            ordersComboBox.FormattingEnabled = true;
            ordersComboBox.Location = new Point(142, 357);
            ordersComboBox.Name = "ordersComboBox";
            ordersComboBox.Size = new Size(121, 23);
            ordersComboBox.TabIndex = 2;
            ordersComboBox.SelectedIndexChanged += ordersComboBox_SelectedIndexChanged;
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Location = new Point(55, 357);
            label4.Name = "label4";
            label4.Size = new Size(42, 15);
            label4.TabIndex = 1;
            label4.Text = "Orders";
            // 
            // dataGridView4
            // 
            dataGridView4.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView4.Location = new Point(0, 0);
            dataGridView4.Name = "dataGridView4";
            dataGridView4.Size = new Size(795, 327);
            dataGridView4.TabIndex = 0;
            // 
            // WatchResultForm
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(tabControl1);
            Name = "WatchResultForm";
            Text = "WatchResultForm";
            tabControl1.ResumeLayout(false);
            tabPage1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)dataGridView1).EndInit();
            tabPage2.ResumeLayout(false);
            tabPage2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)dataGridView2).EndInit();
            tabPage3.ResumeLayout(false);
            tabPage3.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)dataGridView3).EndInit();
            tabPage4.ResumeLayout(false);
            tabPage4.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)dataGridView4).EndInit();
            ResumeLayout(false);
        }

        #endregion

        private TabControl tabControl1;
        private TabPage tabPage1;
        private TabPage tabPage2;
        private DataGridView dataGridView1;
        private Label label2;
        private DataGridView dataGridView2;
        private Label RemainingNomLabel;
        private TabPage tabPage3;
        private ComboBox buildAreaComboBox;
        private Label label3;
        private DataGridView dataGridView3;
        private TabPage tabPage4;
        private Label label4;
        private DataGridView dataGridView4;
        private ComboBox ordersComboBox;
        private Button cancelOrderButton;
    }
}