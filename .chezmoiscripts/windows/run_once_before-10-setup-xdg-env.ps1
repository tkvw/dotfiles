$xdgVars = @{
    XDG_CONFIG_HOME = [IO.Path]::Combine($env:USERPROFILE, ".config")
    XDG_DATA_HOME   = [IO.Path]::Combine($env:USERPROFILE, ".local", "share")
    XDG_STATE_HOME  = [IO.Path]::Combine($env:USERPROFILE, ".local", "state")
    XDG_CACHE_HOME  = [IO.Path]::Combine($env:USERPROFILE, ".cache")
    XDG_RUNTIME_DIR = [IO.Path]::Combine($env:USERPROFILE, ".local", "run")
}
foreach ($entry in $xdgVars.GetEnumerator()) {
    [Environment]::SetEnvironmentVariable($entry.Key, $entry.Value, "User")
    Write-Host "Set $($entry.Key) to $($entry.Value)"
}

$pathsToAdd = @(
    [IO.Path]::Combine($env:USERPROFILE, ".local", "bin")
    [IO.Path]::Combine($env:USERPROFILE, "scoop", "shims")
    # voeg hier meer paden toe
)
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
$existing = $currentPath -split ";" | Where-Object { $_.Trim() -ne "" }

$added = @()
foreach ($p in $pathsToAdd) {
    # Case-insensitive vergelijking + genormaliseerde paden
    $normalizedExisting = $existing | ForEach-Object { $_.TrimEnd("\") }
    $normalizedP = $p.TrimEnd("\")
    if ($normalizedExisting -notcontains $normalizedP) {
        $existing += $p
        $added += $p
    }
}

if ($added.Count -gt 0) {
    $newPath = ($existing -join ";").TrimEnd(";")
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
}
