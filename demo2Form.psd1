<#
.SYNOPSIS
    Sample form definition for demo2.ps1 script

.DESCRIPTION
    This file contains form definition properties and events are loaded with new-form function in module FormsBuild

.NOTES
    Author  : Claude Débieux - claude@get-code.ch
    More information and working demo on GitHub

.LINK
    https://get-code.ch
    https://github.com/get-code-ch/FormsBuilder
#>

@{
    # DialogForm Definition
    Form     = @{
        # Form properties
        Properties = @{
            Name            = 'Demo2Form'
            Text            = 'AD Users'
            Width           = 808
            Height          = 640
            Anchor          = 'Left,Top'
            AutoSize        = $False
            MaximizeBox     = $False
            MinimizeBox     = $False
            ControlBox      = $True # $True or $False to show close icon on top right corner
            FormBorderStyle = 'FixedSingle' # Fixed3D, FixedDialog, FixedSingle, Sizable, None, FixedToolWindow, SizableToolWindow
        }
        # Form Events (function must defined in calling script)
        Events     = @{
            Load = 'Form_Load'    
        }
    }

    # Controls Definition
    Controls = @(
        ## Start Logon GroupBox
        @{
            Control     = 'Label'
            Properties  = @{
                Name        = 'Label1'
                Text        = 'Server'
                Location    = '16,34'
                Width       = '48'
            }
        },
        @{
            Control     = 'TextBox'
            Properties  = @{
                Name        = 'ServerTB'
                Text        = ''
                Location    = '72,32'
                Width       = 160
            }
            Events     = @{
                TextChanged = 'LogonTextBox_Changed'    
            }
        },
        @{
            Control     = 'Label'
            Properties  = @{
                Name        = 'Label2'
                Text        = 'Username'
                Location    = '240,34'
                Width       = '64'
            }
        },
        @{
            Control     = 'TextBox'
            Properties  = @{
                Name        = 'UsernameTB'
                Text        = ''
                Location    = '312,32'
                Width       = 160
            }
            Events     = @{
                TextChanged = 'LogonTextBox_Changed'    
            }
        },
        @{
            Control     = 'Label'
            Properties  = @{
                Name        = 'Label3'
                Text        = 'Password'
                Location    = '480,34'
                Width       = '64'
            }
        },
        @{
            Control     = 'TextBox'
            Properties  = @{
                Name        = 'PasswordTB'
                Text        = ''
                Location    = '552,32'
                Width       = 160
                PasswordChar    = '*'
            }
            Events     = @{
                TextChanged = 'LogonTextBox_Changed'    
            }
        },
        @{
            Control     = 'Button'
            Properties  = @{
                Text        = 'Logon'
                Name        = 'LogonBtn'
                Location    = '720,28'
                Width       = 56
                Height      = 24
            }
            Events      = @{
                Click       = 'LogonBtn_Click'    
            }
        }
        @{
            Control     = 'GroupBox'
            Properties  = @{
                Name        = 'LogonGB'
                Text        = 'Logon'
                Location    = '4,8'
                Width       = 784
                Height      = 60
            }
        },
        ## End Logon GroupBox

        ## Start UserDGV Definition
        @{
            Control    = 'DataGridView'
            Properties = @{
                Name                 = 'UsersDGV'
                Location    = '8,76'
                Width       = 776
                Height      = 484
                ColumnHeadersVisible = $true
                RowHeadersVisible    = $false
                SelectionMode        = 'FullRowSelect'
                MultiSelect          = $false
                ReadOnly             = $true
            }
        },
        ## End UserDGV

        # Error Messages Label
        @{
            Control     = 'Label'
            Properties  = @{
                Name        = 'ErrorMsgLbl'
                Text        = 'Error message'
                Location    = '8,568'
                Width       = 688
                ForeColor   = 'Red'
                Font        = 'Arial, 10, style=Regular,Bold'
                BorderStyle = 'FixedSingle'
            }
        },
        # Quit Button
        @{
            Control     = 'Button'
            Properties  = @{
                Text        = 'Quit'
                Name        = 'QuitBtn'
                Location    = '704,568'
                Width       = 80
                Height      = 24
            }
            Events      = @{
                Click       = 'QuitBtn_Click'    
            }
        }
    )
}
