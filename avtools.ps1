Function Progress {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=0)]
        [string]$Message = ""
    )

    $ProgressMessage = '== ' + (Get-Date) + ': ' + $Message

    Write-Host $ProgressMessage -ForegroundColor Magenta
}

Function InstallInno {
  $inno_url = "http://files.jrsoftware.org/is/5/innosetup-5.5.9-unicode.exe"

  Progress ("Downloading InnoSetup from: " + $inno_url)
  & "C:\Program Files\Git\mingw64\bin\curl.exe" -s -o ../innosetup.exe -L $inno_url

  Progress "Installig InnoSetup"
  Start-Process -FilePath ..\innosetup.exe -ArgumentList /SILENT -NoNewWindow -Wait

  Progress "InnoSetup installation: Done"
  Get-ItemProperty "C:\Program Files (x86)\Inno Setup 5\ISCC.exe"
}

function CheckExitCode($msg) {
  if ($LastExitCode -ne 0) {
    Throw $msg
  }
}

function SignFiles($files) {
  & $env:SignTool sign /f $env:KeyFile /p "$env:CertPassword" /tr http://sha256timestamp.ws.symantec.com/sha256/timestamp /td sha256 /fd sha256 $files
  CheckExitCode "Failed to sign files."
}

function InnoBuild($iss){
  & "C:\Program Files (x86)\Inno Setup 5\iscc.exe" $iss | Out-File output.log
}
