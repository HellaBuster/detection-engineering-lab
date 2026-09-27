[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [ValidateSet("up", "down", "status", "logs", "test")]
    [string]$Action = "status",

    [Parameter(Position = 1)]
    [ValidateSet("core", "browser", "ml", "observability", "all")]
    [string]$Target = "core"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
$env:Path = "$machinePath;$userPath"

$RepositoryRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $RepositoryRoot

if (-not (Test-Path -LiteralPath ".env")) {
    throw ".env is missing. Run scripts/bootstrap.ps1 first."
}

$profiles = switch ($Target) {
    "core" { @("core") }
    "browser" { @("core", "browser") }
    "ml" { @("core", "ml") }
    "observability" { @("core", "observability") }
    "all" { @("all") }
}

$profileArguments = @()
foreach ($profile in $profiles) {
    $profileArguments += @("--profile", $profile)
}

$longRunningServices = switch ($Target) {
    "core" { @("postgres", "api", "frontend") }
    "browser" { @("postgres", "api", "frontend") }
    "ml" { @("postgres", "api", "frontend", "mlflow") }
    "observability" { @("postgres", "api", "frontend", "otel-collector", "prometheus", "grafana") }
    "all" { @("postgres", "api", "frontend", "mlflow", "otel-collector", "prometheus", "grafana") }
}

switch ($Action) {
    "up" {
        docker compose @profileArguments up -d --wait @longRunningServices
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
        if ($Target -eq "browser" -or $Target -eq "all") {
            docker compose @profileArguments run --rm playwright
            exit $LASTEXITCODE
        }
    }
    "down" {
        docker compose --profile core --profile browser --profile ml --profile observability --profile all down
        exit $LASTEXITCODE
    }
    "status" {
        docker compose @profileArguments ps
        exit $LASTEXITCODE
    }
    "logs" {
        docker compose @profileArguments logs --tail 200 --follow
        exit $LASTEXITCODE
    }
    "test" {
        docker compose @profileArguments up -d --wait @longRunningServices
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

        uv run --frozen pytest
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

        fnm exec --using 24 npm.cmd test
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

        if ($Target -eq "browser" -or $Target -eq "all") {
            docker compose @profileArguments run --rm playwright
            exit $LASTEXITCODE
        }
    }
}
