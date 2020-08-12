      $PesterModule = Get-Module -Name Pester -ListAvailable
      if (-Not($PesterModule.Version -gt '5.0.0')) {
        Install-Module -Name Pester -MinimumVersion 5.0.0 -Force -SkipPublisherCheck
      }
      
      $TestsPath = [System.IO.Path]::Combine($PSScriptRoot,'..','Tests')
      
      Invoke-Pester $TestsPath -OutputFile "./Test-HelpDeskPester.XML" -OutputFormat "NUnitXML"
      
