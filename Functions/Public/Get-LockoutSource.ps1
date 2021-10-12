
Function Get-LockoutSource() {
    [CmdletBinding()]
    Param(
        [Parameter(
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [Alias('SAMAccountName')]
        [System.String] $Identity,

        [Parameter()]
        [System.String] $ComputerName = "$((Get-ADDomain).PDCEmulator)"
    )

    Process {
        Try {
            # If object is from the pipe, need to set $User.SAMAccountName value
            If ($_ -is [System.Object]) {
                $User = @{
                    SAMAccountName = $_.SamAccountName
                }
            } Else {
                $User = Get-ADUser $Identity -Properties LockedOut
                If (-Not ($User.LockedOut)) {
                    Throw [System.DirectoryServices.ActiveDirectory.ActiveDirectoryObjectNotFoundException]::new("The user $($User.SamAccountName) is not currently locked out.")
                }
            }
            $params = @{
                LogName      = 'Security'
                ComputerName = $ComputerName
                ErrorAction  = 'SilentlyContinue'
            }
            If ($ComputerName -ne $env:COMPUTERNAME -or 'localhost') {
                $params['ComputerName'] = $ComputerName
            }
            $Event = Get-WinEvent @params | Where-Object { $_.ID -eq '4740'} | Where-Object {(($_.Message) -split '\t')[-3].split([System.Environment]::NewLine)[0] -eq $($User.SamAccountName)} | Select-Object -First 1

            [PSCustomObject] @{
                Identity = $($User.SamAccountName)
                LockoutSource = (($Event.Message) -split '\t')[-1]
            }
        } Catch {
            Throw $_
        }
    }
}
