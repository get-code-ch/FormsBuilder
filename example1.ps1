<#
.SYNOPSIS
    Chargement de la boite de Dialogue
#>
Function FormLoad() {
}

# DataGridView1 event handling
Function DataGridView1_CellClick() {
}
Function DataGridView1_CellDoubleClick() {}

# Textbox change event handling
Function TextBox1_OnChange(){}

Function CancelBtn_Click() {
    $MainForm.Close()
}

Import-Module "$(get-location)\FormsBuilder" -Force

Clear-Host
$FormsFile = "$(get-location)\myform.psd1"

# Loading form and display Dialog
$MainForm = New-Form -FormsFile $FormsFile
$MainForm.ShowDialog()
