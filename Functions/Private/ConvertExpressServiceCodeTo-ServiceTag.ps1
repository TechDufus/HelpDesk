function ConvertExpressServiceCodeTo-ServiceTag() {    
    [CmdletBinding()]
    param ([parameter(valuefrompipeline=$true, HelpMessage="Integer number to convert")][int64]$ExpressServiceCode="")
    $alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    do {
        $remainder = ($ExpressServiceCode % 36)
        $char = $alphabet.substring($remainder,1)
        $ServiceTag = "$char$ServiceTag"
        $ExpressServiceCode = ($ExpressServiceCode - $remainder) / 36
    }
    while ($ExpressServiceCode -gt 0)

    $ServiceTag
}


