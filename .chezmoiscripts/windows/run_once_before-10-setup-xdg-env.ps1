
$xdgVars = @{
    XDG_CONFIG_HOME  = Join-Path $env:USERPROFILE ".config"
    XDG_DATA_HOME    = Join-Path $env:USERPROFILE ".local" "share"
    XDG_STATE_HOME   = Join-Path $env:USERPROFILE ".local" "state"
    XDG_CACHE_HOME   = Join-Path $env:USERPROFILE ".cache"
    XDG_RUNTIME_DIR  = Join-Path $env:USERPROFILE ".local" "run"
}

foreach ($entry in $xdgVars.GetEnumerator()) {
    [Environment]::SetEnvironmentVariable($entry.Key, $entry.Value, "User")
    Write-Host "Set $($entry.Key) to $($entry.Value)"
}
