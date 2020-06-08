<#
Beginner Challenge
When you create a string of text in PowerShell, each character can also be represented by its underlying [CHAR] value which actually has an integer value.
The value can be turned back into the original string character.
#>

# Return Int from Character
function Get-CharInt($Char) {
    [int][char]$Char
}

<#
Your challenge is to define a variable with a string of text, like $w=”Iron Scripter”.
Write a PowerShell expression that will give you the sum of the integer values for each character in the string.
The second part of the challenge is to display the text using its integer values.
#>

$w = "Iron Scripter"

($w.ToCharArray() | ForEach-Object { [int][char]$_ } | Measure-Object -Average -Sum).Sum

<#
Intermediate Challenge
If you have a bit more experience, you should be able to knock out the beginner challenges rather easily.
Your challenge is two write 2 PowerShell functions that will accept pipeline input.
The first function should take a string of text as input and write a new string that uses the CHAR value doubled.
In other words, if the original CHAR value is 111, the new word will use a value of 222. You will definitely get some unusual characters.

The second part of the challenge is to write a function that does the opposite, that is, “decodes” the text.
If you’ve done this properly you should be able to decode this: 'àÞîÊäæÐÊØØ'
#>

function ConvertTo-IntX2 {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Character
    )
    process {
        $Character.ToCharArray() | ForEach-Object { [int][char]$_ * 2 }
    }
}

# Its unclear if the output needs to be returned exactly as the input, for example on the same line.
# Updated to output the results on a single line.
function ConvertFrom-IntX2 {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [int[]]
        $Int
    )
    begin {
        $Output = [System.Collections.ArrayList]@()
    }
    process {
        [void]$Output.Add(($Int | ForEach-Object { $_ / 2 } | ForEach-Object { [char][int]$_ }))
        
    }
    end {
        $Output -join ''
    }
}

$decode = 'àÞîÊäæÐÊØØ'
$decode | ConvertTo-IntX2 | ConvertFrom-IntX2