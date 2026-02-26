# $xdgVars = @{
#     XDG_CONFIG_HOME = [IO.Path]::Combine($env:USERPROFILE, ".config")
#     XDG_DATA_HOME   = [IO.Path]::Combine($env:USERPROFILE, ".local", "share")
#     XDG_STATE_HOME  = [IO.Path]::Combine($env:USERPROFILE, ".local", "state")
#     XDG_CACHE_HOME  = [IO.Path]::Combine($env:USERPROFILE, ".cache")
#     XDG_RUNTIME_DIR = [IO.Path]::Combine($env:USERPROFILE, ".local", "run")
# }
# foreach ($entry in $xdgVars.GetEnumerator()) {
#     [Environment]::SetEnvironmentVariable($entry.Key, $entry.Value, "User")
#     Write-Host "Set $($entry.Key) to $($entry.Value)"
# }
$pathsToAdd = @(
    [IO.Path]::Combine($env:USERPROFILE, ".local", "bin")
    # [IO.Path]::Combine($env:USERPROFILE, ".local", "share", "mise", "shims")
    # [IO.Path]::Combine($env:USERPROFILE, "scoop", "shims")
)

$currentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if ([string]::IsNullOrWhiteSpace($currentPath)) {
    $existing = @()
} else {
    $existing = @($currentPath -split ";" | Where-Object { $_.Trim() -ne "" })
}

$added = @()
foreach ($p in $pathsToAdd) {
    $normalizedExisting = $existing | ForEach-Object { $_.TrimEnd("\").ToLower() }
    $normalizedP = $p.TrimEnd("\").ToLower()
    if ($normalizedExisting -notcontains $normalizedP) {
        $existing += $p
        $added += $p
    }
}

if ($added.Count -gt 0) {
    $newPath = ($existing -join ";")
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
    foreach ($a in $added) {
        Write-Host "Added to PATH: $a"
    }
} else {
    Write-Host "PATH already up to date."
}
