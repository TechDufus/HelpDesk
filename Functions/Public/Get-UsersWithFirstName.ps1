#Region Get-UsersWithFirstName

<#
.SYNOPSIS
    This function performs a search of users in ActiveDirectory for a first name.
.DESCRIPTION
    This function is a simple Get-ADUser with a filter for GivenName to generate a list of users with the provided first name. This function provides the Name, SAMAccountName, and Office for each user with the specified first name. These are sorted by office first, and then name second.
.PARAMETER FirstName
    This parameter should specify the ActiveDirectory account GivenName (first name). This parameter will only accept alpha characters and will halt the function if it detects numeric characters.
.PARAMETER Properties
    This parameter will declare additional properties to include with the default values generated. To see what other properties can be included, fun this function against a name that is successful and add "| Get-Member" to get a list. The items with a MemberType of NoteProperty can be named in this -Properties parameter separated by commas.

    Example
    -------
    FirstName Matthew | Get-Member
.INPUTS
    System.String
        This function does not accept pipeline data. The values for all parameters must be specified.
.OUTPUTS
    System.Object[]
        Objects generated from the AD query.
.EXAMPLE
    PS>Get-UsersWithFirstName Matt -Properties Title

    Name                          SamAccountName Office          Title
    ----                          -------------- ------          -----
    JoeBobJenkins, Matt           mjoebob        Chicago         Position
    Jackson, Matt                 mjackso        Chicago         Position
    Williamson-bob, Matt          mwillia        Boston-North    Position
    Zachery, Matt                 mzacher        Boston-East     Position
    Zebras, Matt                  mzebras        Chicago         Position

    Description
    -----------
    This will find all ActiveDirectory users with the first name of 'Matt' and display the results.
.EXAMPLE
    PS>Get-FirstName FakeName

    FName : There is no user with 'FakeName' as their first name.

    Description
    -----------
    This will display an error indicating there were no users who matched the first name provided.
.EXAMPLE
    PS>fname michael

    Desctiption
    -----------
    This example shows using the alias for this function. The alias is FName.
.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
function Get-UsersWithFirstName() {
    [CmdletBinding()]
    param (
        [string[]] $Properties,

        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateLength(1, 33)]
        [ValidateScript( { if ($_ -match '\d') {
                    throw('Parameter -FirstName should only contain alpha characters.')
                }
                else {
                    return $true
                }
            })]
        [string]$FirstName
    )

    $Filter = "GivenName -eq `"$FirstName`""
    $Users = Get-ADUser -Filter $Filter -Properties GivenName, Surname, Manager, Office, OfficePhone, Title
    $i = 0
    $Users | ForEach-Object {
        $i++
    }

    if ($i -eq 1) {
        Lookup -Username $Users.SamAccountName
    } else {
        ##Set up the default display set and create the member set object for use later on
        #Configure a default display set
        if ($Properties -eq '*') {
            $DefaultDisplaySet = 'Name', 'FirstName', 'LastName', 'Manager', 'Office', 'Phone', 'Gender', 'Title', 'SamAccountName'
        }
        elseif ($Properties -and $Properties -ne '*') {
            $DefaultDisplaySet = 'Name', 'SamAccountName', 'Office'
            $DefaultDisplaySet += $Properties
        }
        else {
            $DefaultDisplaySet = 'Name', 'SamAccountName', 'Office'
        }

        #Create the default property display set
        $DefaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet('DefaultDisplayPropertySet', [string[]]$DefaultDisplaySet)
        $PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($DefaultDisplayPropertySet)

        $Results = $Users | ForEach-Object {
            try {
                $Manager = $(Get-ADUser $_.Manager -ErrorAction Stop ).Name
            }
            catch {
                $Manager = "Unavailable"
            }
            $object = [pscustomobject]@{
                Name           = $_.Name
                FirstName      = $_.GivenName
                LastName       = $_.Surname
                Manager        = $Manager
                Office         = $_.Office
                Phone          = $_.OfficePhone
                Title          = $_.Title
                SamAccountName = $_.SamAccountName
            }

            #Give this object a unique typename
            $object.PSObject.TypeNames.Insert(0, 'User.Information')
            $object | Add-Member MemberSet PSStandardMembers $PSStandardMembers

            $Object
        }
        if ($Results) {
            $Results
        }
        else {
            Write-Error "There is no user with '$FirstName' as their first name."
        }
    }
}
#EndRegion Get-UsersWithFirstName