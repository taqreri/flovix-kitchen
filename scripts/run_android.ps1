param(
    [Parameter()]
    [ValidateSet("production", "staging")]
    [string]$Flavor = "production"
)

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $PSScriptRoot
$envFile = Join-Path $projectRoot "env\$Flavor.json"

if (-not (Test-Path $envFile)) {
    throw "Missing env file: $envFile"
}

Push-Location $projectRoot
try {
    flutter run `
        --flavor $Flavor `
        -t lib/main.dart `
        --dart-define-from-file="env/$Flavor.json" `
        @args
} finally {
    Pop-Location
}
