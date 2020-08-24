# Changelog for HelpDesk

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
