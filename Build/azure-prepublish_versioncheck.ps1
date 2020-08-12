#Get current PSGallery Version
$PSGalleryModule = Find-Module HelpDesk -Repository PSGallery -ErrorAction SilentlyContinue

#Get current GitHub Manifest version (From cloned repo in AzurePipelines)
$CurrentModule = Test-ModuleManifest -Path ([System.IO.Path]::Combine("HelpDesk","HelpDesk.psd1"))

#Ensure this is either an initial publish to PSGallery, or that the GitHub version is higher than the PSGallery version
if ($CurrentModule.Version -gt $PSGalleryModule.Version -or (-Not($PSGalleryModule))) {
  Write-Output "PSGallery: v$($PSGalleryModule.Version)"
  Write-Output "Github: v$($CurrentModule.Version)"
  Write-Output "Attempting to publish new version $($CurrentModule.Version) to the PowerShell Gallery."
  Publish-Module -Path $CurrentModule.ModuleBase -Repository PSGallery -NuGetApiKey $env:PSGALLERY_API_KEY -Verbose
} else {
  Write-Output "GitHub Module version ($($CurrentModule.Version)) | PSGallery Module version ($($PSGalleryModule.Version)). Pipeline module version is not greater than the Published PSGallery module version."
}