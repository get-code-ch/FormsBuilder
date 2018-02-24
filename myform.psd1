@{
    Name     = 'MyForm'
    Text     = 'myform'
    Width    = 400
    Height   = 400
    Anchor   = 'Left,Top'

    Controls = @(
        # Forms Buttons
        @{
            Control    = "Button"
            Properties = @{
                Text   = 'Quitter'
                Name   = 'CancelBtn'
                Top  = 300
                Left   = 170
                Width  = 60
            }           
        },
        # Groups
        @{
            Control    = "Label"
            Properties = @{
                Text  = 'Label'
                Name  = 'Label'
                Top   = 7
                Left  = 5
                Width = 50
            }
        },
        @{
            Control    = "DataGridView"
            Properties = @{
                Name                 = 'DataGridView1'
                Top                  = 40
                Left                 = 5
                Height               = 200
                Width                = 375
                ColumnHeadersVisible = $false
                RowHeadersVisible    = $false
                SelectionMode        = 'FullRowSelect'
                MultiSelect          = $false
            }
        },
        @{
            Control    = "TextBox"
            Properties = @{
                Name  = 'TextBox1'
                Top   = 7
                Left  = 60
                Width = 210
            }
        }
    )

}
