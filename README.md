# HelpDesk
Many useful ActiveDirectory and other admin-type utilities typical in a HelpDesk role.

[![Build Status](https://dev.azure.com/matthewjdegarmo/HelpDesk/_apis/build/status/matthewjdegarmo.HelpDesk?branchName=master&jobName=Job)](https://dev.azure.com/matthewjdegarmo/HelpDesk/_build/latest?definitionId=2&branchName=master)
![License](https://img.shields.io/github/license/matthewjdegarmo/HelpDesk)
<!--
[![Known Vulnerabilities](https://snyk.io/test/github/dwyl/hapi-auth-jwt2/badge.svg)](https://snyk.io/test/github/matthewjdegarmo/HelpDesk)
-->
## Installing
### For Windows PowerShell 5.1 ###
```powershell
# For CurrentUser scope
git clone https://github.com/matthewjdegarmo/HelpDesk.git ($env:PSModulePath -split ';')[0]

# For AllUsers scope. Must be Admin.
git clone https://github.com/matthewjdegarmo/HelpDesk.git ($env:PSModulePath -split ';')[2]
```
### For PowerShell 6.0+ ###
```powershell
# For CurrentUser scope
git clone https://github.com/matthewjdegarmo/HelpDesk.git $PSGetPath.CurrentUserModules

# For AllUsers scope. Must be Admin.
git clone https://github.com/matthewjdegarmo/HelpDesk.git $PSGetPath.AllUsersModules
```

PowerShell will now Auto-Load the commands in this module.

## Updating
Navigate into the cloned HelpDesk folder and run `git pull` to pull the current main (master) branch.
### For Windows PowerShell 5.1 ###
```powershell
# For CurrentUser scope
Set-Location (Join-Path -Path ($env:PSModulePath -split ';')[0] -ChildPath HelpDesk)
git pull

# For AllUsers scope. Must be Admin.
Set-Location (Join-Path -Path ($env:PSModulePath -split ';')[2] -ChildPath HelpDesk)
git pull
```
### For PowerShell 6.0+ ###
```powershell
# For CurrentUser scope
Set-Location (Join-Path -Path $PSGetPath.CurrentUserModules -ChildPath HelpDesk)
git pull

#For AllUsers scope. Must be Admin
Set-Location (Join-Path -Path $PSGetPath.AllUsersModules -ChildPath HelpDesk)
git pull
```
