[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = "Continue"

$RepositoryRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $RepositoryRoot

$machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
$env:Path = "$machinePath;$userPath"

$script:Failures = 0

function Report {
    param(
        [Parameter(Mandatory)][bool]$Ok,
        [Parameter(Mandatory)][string]$Name,
        [Parameter(Mandatory)][string]$Detail,
        [switch]$Optional
    )

    if ($Ok) {
        Write-Host "[ok]   $Name - $Detail" -ForegroundColor Green
    } elseif ($Optional) {
        Write-Host "[warn] $Name - $Detail" -ForegroundColor Yellow
    } else {
        Write-Host "[fail] $Name - $Detail" -ForegroundColor Red
        $script:Failures++
    }
}

function Capture {
    param([Parameter(Mandatory)][scriptblock]$Action)
    try {
        return ((& $Action 2>&1) | Out-String).Trim()
    } catch {
        return ""
    }
}

$requiredFiles = @(
    "pyproject.toml",
    "uv.lock",
    ".python-version",
    "package.json",
    "package-lock.json",
    ".node-version",
    "compose.yaml"
)
foreach ($file in $requiredFiles) {
    Report -Ok (Test-Path -LiteralPath $file) -Name "manifest" -Detail $file
}

$uv = Get-Command uv -ErrorAction SilentlyContinue
Report -Ok ($null -ne $uv) -Name "uv" -Detail $(if ($uv) { Capture { uv --version } } else { "not on PATH" })
if ($uv) {
    $pythonVersion = Capture { uv run --frozen python --version }
    Report -Ok ($pythonVersion -match "Python 3\.13\.") -Name "project Python" -Detail $pythonVersion
}

$fnm = Get-Command fnm -ErrorAction SilentlyContinue
Report -Ok ($null -ne $fnm) -Name "fnm" -Detail $(if ($fnm) { Capture { fnm --version } } else { "not on PATH" })
if ($fnm) {
    $nodeVersion = Capture { fnm exec --using 24 node --version }
    Report -Ok ($nodeVersion -match "^v24\.") -Name "project Node" -Detail $nodeVersion
    $npmVersion = Capture { fnm exec --using 24 npm.cmd --version }
    Report -Ok (-not [string]::IsNullOrWhiteSpace($npmVersion)) -Name "npm" -Detail $npmVersion
}

$policy = Get-ExecutionPolicy -Scope CurrentUser
Report -Ok ($policy -eq "RemoteSigned") -Name "PowerShell policy" -Detail $policy

$gitVersion = Capture { git --version }
Report -Ok ($gitVersion -match "git version") -Name "Git" -Detail $gitVersion

$dockerVersion = Capture { docker --version }
Report -Ok ($dockerVersion -match "Docker version") -Name "Docker CLI" -Detail $dockerVersion
$dockerServer = Capture { docker info --format "{{.ServerVersion}}" }
Report -Ok (-not [string]::IsNullOrWhiteSpace($dockerServer)) -Name "Docker engine" -Detail $dockerServer

if (Test-Path -LiteralPath ".env") {
    Report -Ok $true -Name "local environment" -Detail ".env exists and is not printed"
    $ignoreResult = Capture { git check-ignore .env }
    Report -Ok ($ignoreResult -eq ".env") -Name "secret hygiene" -Detail ".env is gitignored"
    docker compose --profile all config --quiet 2>$null
    Report -Ok ($LASTEXITCODE -eq 0) -Name "Compose config" -Detail "all profiles resolve"
} else {
    Report -Ok $false -Name "local environment" -Detail ".env missing; run bootstrap.ps1"
}

$wiresharkCandidates = @(
    "C:\Program Files\Wireshark\Wireshark.exe",
    "C:\Program Files\Wireshark\tshark.exe"
)
$wiresharkInstalled = $wiresharkCandidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
Report -Ok ($null -ne $wiresharkInstalled) -Name "Wireshark" -Detail $(if ($wiresharkInstalled) { $wiresharkInstalled } else { "not found" })

$expectedPorts = 3000, 5000, 5173, 55432, 8000, 9090, 4317, 4318
foreach ($port in $expectedPorts) {
    $listener = Get-NetTCPConnection -State Listen -LocalPort $port -ErrorAction SilentlyContinue | Select-Object -First 1
    $detail = if ($listener) { "listening (PID $($listener.OwningProcess))" } else { "available while stack is stopped" }
    Report -Ok $true -Name "port $port" -Detail $detail -Optional
}

$containers = Capture { docker compose --profile all ps --format "{{.Service}}={{.State}}" }
if ([string]::IsNullOrWhiteSpace($containers)) {
    Report -Ok $false -Name "Compose services" -Detail "stopped; use scripts/stack.ps1 up core" -Optional
} else {
    Report -Ok $true -Name "Compose services" -Detail ($containers -replace "`r?`n", ", ")
}

if ($script:Failures -gt 0) {
    Write-Host "Doctor found $script:Failures blocking issue(s)." -ForegroundColor Red
    exit 1
}

Write-Host "Environment is ready." -ForegroundColor Green
exit 0
