<#
.SYNOPSIS
    Chargement de la boite de Dialogue
#>
Function Form_Load() {
    Write-Output 'Form loaded...'
}

# DataGridView1 event handling
Function DataGridView1_CellClick() {
}
Function DataGridView1_CellDoubleClick() {}

# Textbox change event handling
Function TextBox1_OnChange(){
    $changedText = $this.Text
    $OutTextControl = $MainForm.Controls['Label3']
    if (!$changedText -eq '') {
        $OutTextControl.Text = $this.Text
    } else {
        $OutTextControl.Text = '<Text>'
    }
}

function DateTimePicker1_ValueChanged () {
    $SelectedDate = $this.Value.ToString("dd-MMM-yyyy")
    $OutDatePickerControl = $MainForm.Controls['LabelDate1']
    $OutDatePickerControl.Text = $selectedDate
}

Function QuitBtn_Click() {
    $MainForm.Close()
}

Import-Module ".\FormsBuilder" -Force

Clear-Host
$FormsFile = ".\demo1Form.psd1"

# Loading form and display Dialog
$MainForm = New-Form -FormsFile $FormsFile
$MainForm.ShowDialog()
