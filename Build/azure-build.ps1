$ModuleName = "HelpDesk"
$ModulePathTarget = "$ModuleName`_Build"
$ModuleTargetFile = [System.IO.Path]::Combine($ModuleTargetPath,$ModuleName,"$ModuleName.psm1")
$ManifestPathSource = [System.IO.Path]::Combine($ModuleName,"$ModuleName.psd1")
$ManifestPathTarget = [System.IO.Path]::Combine($ModulePathTarget,$ModuleName,"$ModuleName.psd1")

$ScriptsPath = [System.IO.Path]::Combine($ModulePathSource,"Functions",'*.ps1')
$ScriptFunctions = @( Get-ChildItem -Path $ScriptsPath -ErrorAction SilentlyContinue -Recurse )

New-Item -Name "$ModuleName" -Path "$ModulePathTarget" -ItemType Directory -Force

foreach ($FilePath in $ScriptFunctions) {
    $Results = [System.Management.Automation.Language.Parser]::ParseFile($FilePath, [ref]$null, [ref]$null)
    $Functions = $Results.Extent.Text
    $Functions | Add-Content -Path $ModuleTargetFile -Force
}

Copy-Item -Path $ManifestPathSource $ManifestPathTarget -Force
