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
    foreach ($k in $FormDef.Form.Properties.Keys) {
        $WinForms.$k = $FormDef.Form.Properties.$k
    }

    foreach ($k in $FormDef.Form.Events.Keys) {
        $evt = "Add_$($k)"
        $fct = [Scriptblock]::Create($($FormDef.Form.Events.$k))
        $WinForms.$evt($fct) 
    }

    foreach ($control in $FormDef.Controls) {
        $evt = $null
        $fct = $null
        $c = New-Object System.Windows.Forms.$($control.Control)

        foreach ($k in $control.Properties.Keys) {
            $c.$k = $control.Properties.$k
        }

        foreach ($k in $control.Events.Keys) {
            $evt = "Add_$($k)"
            $fct = [Scriptblock]::Create($($control.Events.$k))
            $c.$evt($fct) 
        }
        $WinForms.Controls.Add($c)
    }
    
    return $WinForms
}

Export-ModuleMember -Function *