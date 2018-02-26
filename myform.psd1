@{
    # DialogForm Definition
    Form     = @{
        # Form properties
        Properties = @{
            Name            = 'MyForm'
            Text            = 'myform'
            Width           = 400
            Height          = 400
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
        @{
            Control    = "Label"
            Properties = @{
                Text  = 'Text'
                Name  = 'Label1'
                Top   = 7
                Left  = 5
                Width = 60
                xsfdiusef = 'www'
            }
        },
        @{
            Control    = "TextBox"
            Properties = @{
                Name  = 'TextBox1'
                Top   = 7
                Left  = 70
                Width = 210
            }
            # Hanling event when text is changed
            Events     = @{
                TextChanged = 'TextBox1_OnChange'    
                xsfdiusef = 'www'
            }
        },
        @{
            Control    = "Label"
            Properties = @{
                Text  = 'TextBox1'
                Name  = 'Label2'
                Top   = 40
                Left  = 5
                Width = 60
            }
        },
        @{
            Control    = "Label"
            Properties = @{
                Text  = '<Text>'
                Name  = 'Label3'
                Top   = 40
                Left  = 70
                Width = 210
            }
        },
        @{
            Control    = "DataGridView"
            Properties = @{
                Name                 = 'DataGridView1'
                Top                  = 70
                Left                 = 5
                Height               = 200
                Width                = 100
                ColumnHeadersVisible = $false
                RowHeadersVisible    = $false
                SelectionMode        = 'FullRowSelect'
                MultiSelect          = $false
            }
            Events     = @{
                CellClick = 'DataGridView1_CellClick'
                CellDoubleClick = 'DataGridView1_CellDoubleClick'
            }
        }
        # Form Quit Button
        @{
            Control    = "Button"
            Properties = @{
                Text  = 'Quit'
                Name  = 'QuitBtn'
                Top   = 300
                Left  = 170
                Width = 60
            }
            Events     = @{
                Click = 'QuitBtn_Click'    
            }
        } 
    )

}
