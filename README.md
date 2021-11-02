# HelpDesk
Many useful ActiveDirectory and other admin-type utilities typical in a HelpDesk role.

<!-- [![Build Status](https://dev.azure.com/matthewjdegarmo/HelpDesk/_apis/build/status/matthewjdegarmo.HelpDesk?branchName=master)](https://dev.azure.com/matthewjdegarmo/HelpDesk/_build/latest?definitionId=1&branchName=master) -->
[![Build](https://github.com/matthewjdegarmo/HelpDesk/workflows/Build%20and%20Publish/badge.svg)](https://github.com/matthewjdegarmo/HelpDesk/actions?query=workflow%3A%22Version+Check+%2B+Publish+to+PSGallery%22)
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

This module features some repetitive ActiveDirectory / HelpDesk type tasks that you hopefully find useful!

## Several example tasks:

- Adding / Removing users as Local Admins on their computers.
  - See [Get-LocalAdmin](https://github.com/matthewjdegarmo/HelpDesk/blob/master/Functions/Public/Get-LocalAdmin.ps1), [Add-LocalAdmin](https://github.com/matthewjdegarmo/HelpDesk/blob/master/Functions/Public/Add-LocalAdmin.ps1), and [Remove-LocalAdmin](https://github.com/matthewjdegarmo/HelpDesk/blob/master/Functions/Public/Remove-LocalAdmin.ps1).
- Enable / Disable ActiveDirectory user accounts.
  - See [Enable-Account](https://github.com/matthewjdegarmo/HelpDesk/blob/master/Functions/Public/Enable-Account.ps1) and [Disable-Account](https://github.com/matthewjdegarmo/HelpDesk/blob/master/Functions/Public/Disable-Account.ps1).
- Get User Lockout information, including the troublesome source of the lockout event.
  - See [Get-LockedOutADUsers](https://github.com/matthewjdegarmo/HelpDesk/blob/master/Functions/Public/Get-LockedOutADUsers.ps1), and the `-IncludeLockoutSource` parameter.
- Securely reset user passwords.
  - See [Reset-Password](https://github.com/matthewjdegarmo/HelpDesk/blob/master/Functions/Public/Reset-Password.ps1).


## Testimonials

`Get-LockedOutADUsers -IncludeLockoutSource` (aliased as `glo`)
- 'This is f**king awesome!' - Friend's boss.
