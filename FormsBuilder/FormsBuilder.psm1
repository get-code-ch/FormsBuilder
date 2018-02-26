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
        if ($WinForms.PSobject.Properties.Name -match $k) {
            $WinForms.$k = $FormDef.Form.Properties.$k
        } else {
            Write-Error -Message "Error: Property $k not exist in windows.form.forms control"
            exit
        }
    }

    foreach ($k in $FormDef.Form.Events.Keys) {
        $evt = "Add_$($k)"
        if ($WinForms.PSobject.Methods.Name -match $evt) {
            $fct = [Scriptblock]::Create($($FormDef.Form.Events.$k))
            $WinForms.$evt($fct) 
        } else {
            Write-Error -Message "Error: Event $k not exist for windows.form.forms control"
            exit
        }
    }

    foreach ($control in $FormDef.Controls) {
        $evt = $null
        $fct = $null
        $c = New-Object System.Windows.Forms.$($control.Control) -ErrorAction SilentlyContinue -ErrorVariable NewObjectError 

        if ($NewObjectError) {
            Write-Error -Message "Error: $($control.Control) invalid for windows.forms"
            exit
        }

        foreach ($k in $control.Properties.Keys) {
            if ( $c.psobject.properties.name -match $k) {
                $c.$k = $control.Properties.$k
            } else {
                Write-Error -Message "Error: $($control.Properties.Name) Property $k not exist for $c control"
                exit
            }

        }

        foreach ($k in $control.Events.Keys) {
            $evt = "Add_$($k)"
            $fct = [Scriptblock]::Create($($control.Events.$k))
            if ($c.PSObject.Methods.Name -match $evt) {
                $fct = [Scriptblock]::Create($($control.Events.$k))
                $c.$evt($fct) 
            } else {
                Write-Error -Message "Error: $($control.Properties.Name) Event $k not exist for $c control"
                exit
            }
        }
        $WinForms.Controls.Add($c)
    }
    
    return $WinForms
}

Export-ModuleMember -Function *