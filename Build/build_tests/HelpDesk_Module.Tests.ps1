#Requires -Modules @{ModuleName="Pester";ModuleVersion="5.0.0"}
$script:ThisRoot = Split-Path $PSScriptRoot -Parent
Remove-Module HelpDesk -ErrorAction SilentlyContinue
Import-Module ([System.IO.Path]::Combine($script:ThisRoot, 'HelpDesk.psd1')) -Force
Describe "HelpDesk Module" {
    It "Imports Successfully" {
        Get-Module HelpDesk | Should -Not -BeNullOrEmpty
    }
    Context 'Functions' {
        It 'All: should import successfully' {
            $PublicImportedCommands = (Get-Command -Module HelpDesk).Name
            $FunctionRegex = '^Function .+?.(?=\()'
            $AllFunctions = ((Get-Content (Join-Path $script:ThisRoot 'HelpDesk.psm1') | Select-String -Pattern $FunctionRegex).Matches.value | Foreach-Object {@($_ -Split ' ')[1]}) | Sort-Object
            $PrivateFunctions = (Compare-Object $PublicImportedCommands $AllFunctions).InputObject

            ($PublicImportedCommands + $PrivateFunctions | Sort-Object) | Should -Be $AllFunctions
        }

        It "Should be valid PowerShell code" {
            $FileContent = Get-Content (Join-Path $script:ThisRoot 'HelpDesk.psm1') -ErrorAction Stop
            $Errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize($FileContent, [ref]$errors)
            $errors.Count | Should -be 0
        }
    }
}