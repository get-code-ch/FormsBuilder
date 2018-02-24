Add-Type -AssemblyName System.Windows.Forms 
Add-Type -AssemblyName System.Drawing 

function New-Form () {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True, 
            ValueFromPipeline = $False,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = 'File contenaining form definition')]
        [string]$FormsFile
    )

    # Get forms definition
    Import-LocalizedData -BaseDirectory (Split-Path $FormsFile) -FileName (Split-Path $FormsFile -Leaf) -BindingVariable 'FormDef'

    $WinForms = New-Object System.Windows.Forms.Form 
    
    $WinForms.AutoSize = $False 
    $WinForms.Text = $FormDef.Text
    $WinForms.Name = $FormDef.Name
    $WinForms.Anchor = $FormDef.Anchor
    
    $WinForms.Width = $FormDef.Width
    $WinForms.Height = $FormDef.Height
    $WinForms.Add_Load( { FormLoad | Out-Null })
    
    foreach ($control in $FormDef.Controls) {
        $c = New-Object System.Windows.Forms.$($control.Control)
        foreach ($p in $control.Properties) {
            foreach ($k in $p.Keys) {
                $c.$k = $p.$k
            }
        
            if ($control.Control -eq 'Button') {
                if ($control.ContainsKey('Action')) {
                    $fct = [Scriptblock]::Create($control.Action)
                }
                else {
                    $fct = [Scriptblock]::Create("$($control.Properties.Name)_Click")
    
                }
                $c.add_click( $fct )
            }
    
            if ($control.Control -eq 'TextBox') {
                if ($control.ContainsKey('Action')) {
                    $fct = [Scriptblock]::Create($control.Action)
                }
                else {
                    $fct = [Scriptblock]::Create("$($control.Properties.Name)_OnChange | Out-Null")
    
                }
                $c.add_textChanged( $fct )
            }

            if ($control.Control -eq 'DataGridView') {
                $fct = [Scriptblock]::Create("$($control.Properties.Name)_CellDoubleClick")
                $c.add_CellDoubleClick( $fct )
                $fct = [Scriptblock]::Create("$($control.Properties.Name)_CellClick")
                $c.add_CellClick( $fct )
            }
<#
            if ($control.Control -eq 'DataGridView') {
                if ($control.ContainsKey('Action')) {
                    $fct = [Scriptblock]::Create($control.Action)
                }
                else {
                    $fct = [Scriptblock]::Create("$($control.Properties.Name)CellDoubleClick")
                }
                $c.add_CellDoubleClick( $fct )
            }
#>
            $WinForms.Controls.Add($c)
        }
    }
    
    return $WinForms

}

Export-ModuleMember -Function *