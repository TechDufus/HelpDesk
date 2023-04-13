# Changelog for HelpDesk

## v1.1.0.3

`Documentation`:

Updating the Repo owner name to `TechDufus`.
  - This was a rename of the repo, not an ownership change.
  - I feel this warranted a version bump to get this updated in all help docs for this module.

## v1.1.0.2

`Get-LockedOutADUsers`: Aliased as `GLO`

+ Added an additional warning message for users who do now have permissions to perform `-IncludeLockoutSource`
  + This message points them to the help documentation with a suggestion on the permissions they might need to do this in their domain.

## v1.1.0

`New Features!`:

+ `Get-LockedOutADUsers`: Aliased as `GLO`
  + This function just got a big feature for those admins who have access.
  + This function can now provide the source of the user lockout event.
    + You must have rights to query your domain controller for Security Event Logs.
      + See `Get-Help GLO -Parameter IncludeLockoutSource` for more information on read access to DC logs.
  + See `Get-Help GLO -Parameter IncludeLockoutSource` for more information.
  + With this, the following command will now be possible (if you have domain rights):

```txt
PS> GLO -IncludeLockoutSource

Name                SamAccountName LockoutTime        LockoutSource
----                -------------- -----------        -------------
DeGarmo, Matthew J. matthewjd      6/26/2019 13:32:15 Some-Computer
```

## v1.0.6
+ Syntax changes in function definitions
  + This does not contain any features or major code changes.
+ New build process
  + Testing, Building, and Publishing this module now exist exclusively within GitHub (from Azure DevOps)
  + This change is to remain in the GitHub ecosystem and have a singular location to handle maintinance.

## v1.0.5
+ Adding GitHub Project links to the .NOTES section of every public function.
+ Misc. code improvements.

## v1.0.4
+ Fixing Comment-Based help.
  + Needed a blank line after the #Region declaration or it broke the built-in help.

## v1.0.3
+ FIX: Fixed parameter set definitions for Remove-UserProfile.
  + Before, you could not use -All since -Username was mandatory, this has been corrected.

## v1.0.2
+ FIX: Issue #1- Fixed default -Domain value for the following
+ Get-LockedOutADUsers no longer gives output if there are no users locked out.
+ Added Regions to each script file. Should help organize the .psm1 file POST-Build.
+ Added Region detection to Pester tests.

## v1.0.1 🤷‍♂️
+ Adding Build job in Azure.
  + Module will now be installed as core .psd1 and .psm1 files instead of entire raw directory.

## v1.0.0 🤖
+ Initial release! 🎂
