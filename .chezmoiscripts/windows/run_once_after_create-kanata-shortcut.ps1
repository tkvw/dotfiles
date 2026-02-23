$WshShell = New-Object -ComObject WScript.Shell
$StartupPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup")
$Shortcut = $WshShell.CreateShortcut("$StartupPath\Kanata.lnk")
$Shortcut.TargetPath = "$env:USERPROFILE\.local\bin\kanata.exe"
$Shortcut.WorkingDirectory = "$env:USERPROFILE\.config\kanata"
$Shortcut.Description = "Kanata keymapping"
$Shortcut.Arguments = '--cfg kanata.kbd'
$Shortcut.Save()
