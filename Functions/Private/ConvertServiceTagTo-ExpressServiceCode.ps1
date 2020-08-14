#Region ConvertServiceTagTo-ExpressServiceCode
Function ConvertServiceTagTo-ExpressServiceCode{ 
    [CmdletBinding(DefaultParameterSetName='ServiceTag')]
    param( 
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="ServiceTag")]
        [System.String] $ServiceTag
    ) 
        
    begin{}
    
    process{
        try {
            $Range = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            $ServiceTag_CharacterArray = $ServiceTag.ToUpper().ToCharArray()
            [System.Array]::Reverse($ServiceTag_CharacterArray)
            [System.Int64]$ExpressServiceCode=0
    
            $i = 0
            foreach($Character in $ServiceTag_CharacterArray) {
                $ExpressServiceCode += $Range.IndexOf($Character) * [System.Int64][System.Math]::Pow(36,$i)
                $i+=1
            }

            $ExpressServiceCode
        } catch {
            Write-Error "$($_.Exception.Message)"
        }
    }

    end{}
}
#EndRegion ConvertServiceTagTo-ExpressServiceCode\