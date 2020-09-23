#Region Get-User

<#
.SYNOPSIS
    This function performs a quick lookup of an ActiveDirectory user, group membership, and possible computers belonging to that user.
.DESCRIPTION
    This function is a simple Get-ADUser with certain fields to display. This function also uses the user Surname against ActiveDirectory Computer Descriptions to generate a list of possible PC's used by the user. This assumes that the AD Computer Descriptions are being used and that full last names are used. This function also generates a list (if the parameter -Groups is used) of groups that a user is a member of using Get-ADPrincipalGroupMembership.
.PARAMETER Username
    This parameter should specify the ActiveDirectory account name or SamAccountName.
.PARAMETER Groups
    This is a switch that will have the function include a listing of user group membership.
.PARAMETER Computers
    Specifying this switch will check the desired user's last name (SurName) against all AD Computer Descriptions for a possible match.
    If your organization used the ManagedBy value to tie an AD Computer to an AD User, then you can change the script. I will look into how to do both in the future.
.INPUTS
    System.String
        This function does not accept pipeline data. The values for all parameters must be specified.
.OUTPUTS
    None
        This function does not produce output except for write-host data
.EXAMPLE
    PS>Get-User matthewjd

    DisplayName    : DeGarmo, Matthew J.
    Manager        : Elon Musk
    Department     : AI Relations
    Title          : AI Architect
    Office         : Jupiter-K12-A
    Mail           : jpytr_MailMe@AICorp.com
    OfficePhone    : 90acedb3-afb1-4986-99de-378fa797fa58
    IPPhone        : a66f0778
    SamAccountName : matthewjd
    Description    : Head of AI Relations
    PassLastSet    : DATE HERE

    Possible Computers...
    Name        : Some-Computer
    Description : Matthew DeGarmo, AI Relations

    Description
    -----------
    This will display generic information about the user as well as attempt to locate AD Computers that may belong to them.
.EXAMPLE
    PS>Lookup -Username user1 -Groups

    Description
    -----------
    Additionally, this will add the group names from `Get-ADPrincipalGroupMembership` to the beginning of the output. This also shows the usage of the previous command `Lookup`. This is an alias.
.EXAMPLE
    PS>lu user1

    Description
    -----------
    This shows the usage of the alias `LU`, which points to the old command name `Lookup`, which now points to `Get-User`
.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo
    
    Change Log:

    Version: 1.2 - Added Password Last Set date to the end of data. This is useful to help troubleshoot lockout issues.
    Version: 1.1 - Added Description to the user data section.
    Version: 1.0 - Function Creation.
#>
Function Get-User() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('SAMAccountName')]
        [String]$Username,
        [switch]$Groups,
        [switch]$Computers
    )

    begin {
        $Username = $Username.ToUpper()
    }

    process {
        try {
            if ($Groups.IsPresent) {
                Write-Verbose "Groups switch is on. Gathering groups."
                try {
                    Write-Verbose "Generating groups list for Username: $Username"
                    $GroupMembership = Get-ADPrincipalGroupMembership $Username -ErrorAction Stop | Select-Object Name | Sort-Object Name
                }
                catch {
                    Write-Verbose "Failed to generate groups list."
                    Write-Error "Could not retrieve groups for user $($Username.ToUpper())"
                }
            }
            try {
                Write-Verbose "Checking for Username: $Username details."
                $AllUserInfo = Get-ADUser -Identity $Username -Properties "DisplayName", "Department", "Title", "Office", "Mail", "OfficePhone", "IPPhone", "Manager", "Description", "EmployeeID", "pwdLastSet" -ErrorAction Stop
                $User = $AllUserInfo | `
                    Select-Object DisplayName, @{Name = 'Manager'; Expression = { $(Get-ADUser $_.Manager).Name } }, Department, Title, Office, Mail, OfficePhone, IPPhone, EmployeeID, SamAccountName, Description, @{Name = 'PassLastSet'; Expression = { [DateTime]::FromFileTime($_.pwdLastSet) } }
            }
            catch {
                Write-Verbose "Failed to lookup User attributes"
                Throw("The user '$Username' does not exist.")
            }
            if (!$User) {
                Write-Error "The user '$Username' does not exist."
            }
            else {
                if ($Groups.IsPresent) {
                    Write-Verbose "Groups switch is on. Displaying Groups."
                    $GroupMembership.Name
                }
                Write-Verbose "Displaying user attributes."
                $User

                if ($Computers.IsPresent) {
                    $UserDistinguishedName = $AllUserInfo.DistinguishedName
                    $ComputerManagedBy = Get-ADComputer -Filter { ManagedBy -eq $UserDistinguishedName }
                    if ($ComputerManagedBy) {
                        Write-Verbose "Found possible computers. Displaying results."
                        Write-Output "Possible Computers..."
                        $ComputerManagedBy.Name | ForEach-Object {
                            Get-ADComputer -Identity $_ -Properties Description -ErrorAction Stop | Select-Object Name, Description
                        }
                    }
                    else { 
                        $Surname = "*$((Get-ADUser -Identity $Username -Properties SurName).SurName)*"
                        Write-Verbose "Checking for possible computers based on last name: $Surname"
                        try {
                            $Filter = "Description -like `"$Surname`" -and Enabled -eq `"$true`""
                            $PossibleComputers = Get-ADComputer -filter $Filter -Properties Description -ErrorAction Stop | Select-Object Name, Description
                        }
                        catch {}
                        if ($PossibleComputers) {
                            Write-Verbose "Found possible computers. Displaying results."
                            Write-Output "Possible Computers..."
                            $PossibleComputers
                        }
                        else {
                            Write-Verbose "No possible PCs were found."
                            Write-Output "Unable to locate possible Computers for this user..."
                        }
                    }
                }
            }
        }
        catch {
            Write-Error "$($_.Exception.Message) - Line Number: $($_.InvocationInfo.ScriptLineNumber)"
        }
    }
}
#EndRegion Get-User