<#
.SYNOPSIS
    Powershell script for demonstration of usage of FormsBuilder module

.DESCRIPTION
    This script demonstrate usage of FormsBuilder module

    Connection to a remote AD Server
    - Get-Users of AD and display it in a DataGridView

.NOTES
    Author  : Claude Débieux - claude@get-code.ch
    More information and working demo on GitHub

.LINK
    https://get-code.ch
    https://github.com/get-code-ch/FormsBuilder
#>


### Following functions handling event on $MainForm.Form ###
# This function is called when forms is loaded (after $MainForm.Form.ShowDialog())
Function Form_Load() {
    # Filling field with environment variable
    $MainForm.Controls.UsernameTB.Text = "$($env:USERDOMAIN)\$($Env:USERNAME)"
    $MainForm.Controls.ServerTB.Text = $env:LOGONSERVER.Trim('\\')

    # Display information message
    $MainForm.Controls.ErrorMsgLbl.Text = 'Logon to server please...'
    $MainForm.Controls.ErrorMsgLbl.ForeColor = 'DarkGreen'

    # Set default AcceptButton to logonBtn. When user press enter event is like click on button
    $MainForm.Form.AcceptButton = $MainForm.Controls.LogonBtn

    # By default LogonBtn is disable until all logon field are filled
    $MainForm.Controls.LogonBtn.Enabled = $false
    $MainForm.Controls.PasswordTB.Focus()
}
Function LogonBtn_Click() {
    # When LogonBtn is clicked, check if all field are filled
    # Get credential and open session to server

    if ($global:Session) {
        Remove-PSSession -Session $global:Session
    }

    $MainForm.Controls.ErrorMsgLbl.Text = "User login and session loading..."
    $MainForm.Controls.ErrorMsgLbl.ForeColor = 'DarkOrange'

    if ([string]::IsNullOrEmpty($MainForm.Controls.ServerTB.Text) -OR `
        [string]::IsNullOrEmpty($MainForm.Controls.UsernameTB.Text) -OR `
        [string]::IsNullOrEmpty($MainForm.Controls.PasswordTB.Text)) {
            $MainForm.Controls.ErrorMsgLbl.Text = "Server name, username or password is missing..."
            $MainForm.Controls.ErrorMsgLbl.ForeColor = 'DarkOrange'
            $global:Credential = $null
            return
    }

    # Create credential object and Session to the server
    if (!$global:Credential) {
        $EncPassword = $MainForm.Controls.PasswordTB.Text | ConvertTo-SecureString -AsPlainText -Force
        # Remove password in form
        $MainForm.Controls.PasswordTB.Text = '*****'
        $global:Credential = New-Object   System.Management.Automation.PsCredential($MainForm.Controls.UsernameTB.Text ,$EncPassword) 
    }
    $global:Session = New-PSSession -ComputerName $MainForm.Controls.ServerTB.Text -Credential $global:Credential -ErrorAction SilentlyContinue -ErrorVariable LogonError

    # Handling Session Creation status
    if ($global:Session) {
        $MainForm.Controls.ErrorMsgLbl.Text = 'Ready...'
        $MainForm.Controls.ErrorMsgLbl.ForeColor = 'DarkGreen'
    } else {
        $MainForm.Controls.ErrorMsgLbl.Text = "Logon Error: $($LogonError[0])"
        $MainForm.Controls.ErrorMsgLbl.ForeColor = 'Red'
        $global:Credential = $null
        return
    }
    $MainForm.Controls.LogonBtn.Enabled = $false

    Import-PSSession -Session $global:Session -Module ActiveDirectory -Prefix Srv -AllowClobber
    LoadUsersArray
}

Function LogonTextBox_Changed() {
    if ([string]::IsNullOrEmpty($MainForm.Controls.ServerTB.Text) -OR `
        [string]::IsNullOrEmpty($MainForm.Controls.UsernameTB.Text) -OR `
        [string]::IsNullOrEmpty($MainForm.Controls.PasswordTB.Text)) {
            $MainForm.Controls.LogonBtn.Enabled = $false
    } else {
        $MainForm.Controls.LogonBtn.Enabled = $true
    }
    $global:Credential = $null
    return
}
Function QuitBtn_Click() {
    # When Quit button is click we close the form
    if ($global:Session) {
        Remove-PSSession -Session $global:Session
    }

    $MainForm.Form.Close()
}
### End Of $MainForm events handling

Function LoadUsersArray () {
    $global:UserArray.Clear()
    $ADUsers = Get-SrvADUser -Filter * | Select-Object *

    foreach ($u in $ADUsers) {
        $global:UserArray.Add($u)
    }
    # Bind DataGridView1 with UserArray object
    $MainForm.Controls.UsersDGV.DataSource = $global:UserArray
}

### Begining of script ###

# Script variables initialization
$global:UserArray = New-Object System.Collections.ArrayList
$global:Credential = $null
$global:Session = $null

# Building Form
Import-Module ".\FormsBuilder" -Force
$FormsFile = ".\demo2Form.psd1"
$MainForm = New-Form($FormsFile)

# Display the Form
$MainForm.Form.ShowDialog()
