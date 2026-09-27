[CmdletBinding()]
param(
    [switch]$SkipHostInstall,
    [switch]$SkipDockerBuild,
    [switch]$SkipBrowserDownload
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$RepositoryRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $RepositoryRoot

function Refresh-ProcessPath {
    $machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$machinePath;$userPath"
}

function Test-Command {
    param([Parameter(Mandatory)][string]$Name)
    return $null -ne (Get-Command $Name -ErrorAction SilentlyContinue)
}

function Ensure-WingetPackage {
    param(
        [Parameter(Mandatory)][string]$Id,
        [Parameter(Mandatory)][string]$Command
    )

    if (Test-Command $Command) {
        Write-Host "[ok] $Command already available"
        return
    }

    winget list --exact --id $Id --accept-source-agreements --disable-interactivity | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[ok] $Id already installed"
        return
    }

    Write-Host "[install] $Id"
    winget install --exact --id $Id --silent --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        throw "winget failed to install $Id (exit $LASTEXITCODE)"
    }
    Refresh-ProcessPath
}

function Ensure-FnmProfile {
    $profilePath = $PROFILE.CurrentUserAllHosts
    $markerStart = "# >>> detection-engineering-lab fnm >>>"
    $markerEnd = "# <<< detection-engineering-lab fnm <<<"
    $snippet = @'
# >>> detection-engineering-lab fnm >>>
$persistedMachinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$persistedUserPath = [Environment]::GetEnvironmentVariable("Path", "User")
$env:Path = "$persistedMachinePath;$persistedUserPath;$env:Path"
if ($null -ne (Get-Command fnm -ErrorAction SilentlyContinue)) {
    fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
}
# <<< detection-engineering-lab fnm <<<
'@

    $directory = Split-Path -Parent $profilePath
    if (-not (Test-Path -LiteralPath $directory)) {
        [IO.Directory]::CreateDirectory($directory) | Out-Null
    }

    $existing = if (Test-Path -LiteralPath $profilePath) {
        [IO.File]::ReadAllText($profilePath)
    } else {
        ""
    }

    if ($existing.Contains($markerStart)) {
        $pattern = "(?s)$([regex]::Escape($markerStart)).*?$([regex]::Escape($markerEnd))"
        $updated = [regex]::Replace($existing, $pattern, $snippet)
        if ($updated -ne $existing) {
            [IO.File]::WriteAllText($profilePath, $updated, [Text.UTF8Encoding]::new($false))
            Write-Host "[updated] fnm initialization in $profilePath"
        } else {
            Write-Host "[ok] fnm PowerShell initialization already configured"
        }
    } else {
        $separator = if ($existing.Length -eq 0 -or $existing.EndsWith([Environment]::NewLine)) {
            ""
        } else {
            [Environment]::NewLine
        }
        [IO.File]::WriteAllText(
            $profilePath,
            "$existing$separator$snippet$([Environment]::NewLine)",
            [Text.UTF8Encoding]::new($false)
        )
        Write-Host "[configured] fnm initialization in $profilePath"
    }
}

function New-UrlSafeSecret {
    $bytes = [byte[]]::new(32)
    $generator = [Security.Cryptography.RandomNumberGenerator]::Create()
    try {
        $generator.GetBytes($bytes)
    } finally {
        $generator.Dispose()
    }
    return [Convert]::ToBase64String($bytes).Replace("+", "-").Replace("/", "_").TrimEnd("=")
}

function Ensure-EnvironmentFile {
    $path = Join-Path $RepositoryRoot ".env"
    if (Test-Path -LiteralPath $path) {
        Write-Host "[ok] .env already exists"
        return
    }

    $postgresPassword = New-UrlSafeSecret
    $grafanaPassword = New-UrlSafeSecret
    $content = @(
        "POSTGRES_USER=detection_lab",
        "POSTGRES_PASSWORD=$postgresPassword",
        "POSTGRES_DB=detection_lab",
        "GRAFANA_ADMIN_USER=admin",
        "GRAFANA_ADMIN_PASSWORD=$grafanaPassword"
    )
    [IO.File]::WriteAllLines($path, $content, [Text.UTF8Encoding]::new($false))
    Write-Host "[created] .env with local random credentials"
}

Refresh-ProcessPath

if (-not $SkipHostInstall) {
    if (-not (Test-Command winget)) {
        throw "winget is required for host provisioning"
    }

    if ((Get-ExecutionPolicy -Scope CurrentUser) -ne "RemoteSigned") {
        Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
        Write-Host "[configured] CurrentUser execution policy: RemoteSigned"
    }

    Ensure-WingetPackage -Id "astral-sh.uv" -Command "uv"
    Ensure-WingetPackage -Id "Schniz.fnm" -Command "fnm"
    Ensure-WingetPackage -Id "WiresharkFoundation.Wireshark" -Command "Wireshark"
}

Refresh-ProcessPath

if (-not (Test-Command uv)) {
    throw "uv is unavailable after provisioning"
}
if (-not (Test-Command fnm)) {
    throw "fnm is unavailable after provisioning"
}
if (-not (Test-Command docker)) {
    throw "Docker is required and was expected to be installed already"
}

Ensure-FnmProfile

Write-Host "[python] installing and pinning Python 3.13"
uv python install 3.13
uv python pin 3.13
uv lock
uv sync --all-groups --frozen

Write-Host "[node] installing and selecting Node.js 24 LTS"
$node24Version = ((fnm exec --using 24 node --version 2>$null) | Out-String).Trim()
if ($LASTEXITCODE -eq 0 -and $node24Version -match "^v24\.") {
    Write-Host "[ok] Node.js $node24Version already installed"
} else {
    fnm install 24
    if ($LASTEXITCODE -ne 0) {
        throw "fnm failed to install Node.js 24 (exit $LASTEXITCODE)"
    }
}
fnm default 24
fnm exec --using 24 npm.cmd ci

if (-not $SkipBrowserDownload) {
    Write-Host "[playwright] installing managed browsers"
    fnm exec --using 24 npx.cmd playwright install chromium firefox webkit
}

$extensions = @(
    "ms-python.python",
    "ms-python.vscode-pylance",
    "charliermarsh.ruff",
    "ms-toolsai.jupyter",
    "ms-azuretools.vscode-docker",
    "ms-playwright.playwright"
)
if (Test-Command code.cmd) {
    $installedExtensions = @(code.cmd --list-extensions)
    foreach ($extension in $extensions) {
        if ($installedExtensions -contains $extension) {
            Write-Host "[ok] VS Code extension $extension already installed"
        } else {
            code.cmd --install-extension $extension | Out-Host
            if ($LASTEXITCODE -ne 0) {
                throw "VS Code failed to install extension $extension (exit $LASTEXITCODE)"
            }
        }
    }
} else {
    Write-Warning "VS Code CLI is unavailable; extensions were not installed"
}

Ensure-EnvironmentFile

if (-not $SkipDockerBuild) {
    Write-Host "[docker] pulling service images"
    docker compose --profile all pull --ignore-buildable
    Write-Host "[docker] building project images"
    docker compose --profile all build --pull
}

Write-Host "[verify] running environment doctor"
& (Join-Path $PSScriptRoot "doctor.ps1")
if ($LASTEXITCODE -ne 0) {
    throw "Environment doctor reported failures"
}

Write-Host "Bootstrap complete. Open a new PowerShell session to load fnm automatically."
