#Region Get-UsersWithLastName

<#
.SYNOPSIS
    This function performs a search of users in ActiveDirectory for a last name.
.DESCRIPTION
    This function is a simple Get-ADUser with a filter for SurName to generate a list of users with the provided last name. This function provides the Name, SAMAccountName, and Office for each user with the specified last name. These are sorted by office first, and then name second.
.PARAMETER LastName
    This parameter should specify the ActiveDirectory account SurName (last name). This parameter will only accept alpha characters and will halt the function if it detects numeric characters.
.PARAMETER Properties
    This parameter will declare additional properties to include with the default values generated. To see what other properties can be included, fun this function against a name that is successful and add "| Get-Member" to get a list. The items with a MemberType of NoteProperty can be named in this -Properties parameter separated by commas.

    Example
    -------
    Get-UsersWithLastName Matthew | Get-Member
.INPUTS
    System.String
        This function does not accept pipeline data. The values for all parameters must be specified.
.OUTPUTS
    System.Object[]
        Objects generated from the AD query.
.EXAMPLE
    PS>Get-UsersWithLastName Smith -Property Title

    Name            SamAccountName Office         Title
    ----            -------------- ------         -----
    Smith, Deborah  dsmith         Chicago        Position
    Smith, Kent     ksmith         Boston-South   Position
    Smith, Matthew  msmith         Chicago        Position
    Smith, Trent    tsmith         Boston-North   Position

    Description
    -----------
    This will find all ActiveDirectory users with the last name of 'Smith' and display the results.
.EXAMPLE
    PS>LastName FakeName

    LastName : There is no user with 'FakeName' as their last name.

    Description
    -----------
    This will display an error indicating there were no users who matched the last name provided.
.EXAMPLE
    PS>Lname degarmo

    Desctiption
    -----------
    This example shows using the alias for this function. The alias is LName.
.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/HelpDesk/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk
#>
function Get-UsersWithLastName() {
    [CmdletBinding()]
    param (
        [string[]]$Properties,
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateLength(1, 35)]
        [ValidateScript( { if ($_ -match '\d') {
                    throw('Paremeter -LastName should only contain alpha characters.')
                }
                else {
                    return $true
                }
            })]
        [string]$LastName
    )

    $Filter = "Surname -eq `"$LastName`""
    $Users = Get-ADUser -Filter $Filter -Properties GivenName, Surname, Manager, Office, OfficePhone, Title
    $i = 0
    $Users | ForEach-Object {
        $i++
    }

    if ($i -eq 1) {
        Lookup -Username $Users.SamAccountName
    }
    else {

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
        #$Users = Get-ADUser -Filter {Surname -eq $LastName} -Properties GivenName,Surname,Manager,Office,OfficePhone,Title
        $Results = $Users | ForEach-Object {
            try {
                $Manager = $(Get-ADUser $_.Manager -ErrorAction Stop).Name
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

            return $Object
        }
        if ($Results) {
            $Results
        }
        else {
            Write-Error "There is no user with '$LastName' as their last name."
        }
    }
}
#EndRegion Get-UsersWithLastName