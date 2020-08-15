# HelpDesk
Many useful ActiveDirectory and other admin-type utilities typical in a HelpDesk role.

[![Build Status](https://dev.azure.com/matthewjdegarmo/HelpDesk/_apis/build/status/matthewjdegarmo.HelpDesk?branchName=master)](https://dev.azure.com/matthewjdegarmo/HelpDesk/_build/latest?definitionId=1&branchName=master)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/5c2c95ff19f146a8ad59c994bbecbebc)](https://www.codacy.com/manual/matthewjdegarmo/HelpDesk?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=matthewjdegarmo/HelpDesk&amp;utm_campaign=Badge_Grade)
[![PSGallery](https://img.shields.io/powershellgallery/v/HelpDesk?color=G&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/HelpDesk/)
[![Downloads](https://img.shields.io/powershellgallery/dt/HelpDesk?label=Downloads)](https://www.powershellgallery.com/packages/HelpDesk/)
[![License](https://img.shields.io/github/license/matthewjdegarmo/HelpDesk?color=g&label=License)](https://github.com/matthewjdegarmo/HelpDesk/blob/master/LICENSE)
![CodeSize](https://img.shields.io/github/languages/code-size/matthewjdegarmo/HelpDesk?label=Code%20Size)
<!--
[![Known Vulnerabilities](https://snyk.io/test/github/dwyl/hapi-auth-jwt2/badge.svg)](https://snyk.io/test/github/matthewjdegarmo/HelpDesk)
-->
## Install from PowerShell Gallery
```powershell
Install-Module HelpDesk
```
## Update from PowerShell Gallery
```powershell
Update-Module HelpDesk
```

## Install with Git
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

## Update with Git
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
