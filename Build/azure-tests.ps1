$PesterModule = Get-Module -Name Pester -ListAvailable
if (-Not($PesterModule.Version -gt '5.0.0')) {
  Install-Module -Name Pester -MinimumVersion 5.0.0 -Force -SkipPublisherCheck
}

$TestsPath = [System.IO.Path]::Combine($PSScriptRoot,'..','Tests')
$CodeCoverageFunctions = [System.IO.Path]::Combine($PSScriptRoot,'..','Functions','*.ps1')
Invoke-Pester -Script $TestsPath `
              -OutputFile "./Test-HelpDeskPester.XML" `
              -OutputFormat "NUnitXML" `
              -CodeCoverage $CodeCoverageFunctions `
              -CodeCoverageOutputFile 'Test-HelpDeskCoverage.xml' `
              -CodeCoverageOutputFileFormat JaCoCo
