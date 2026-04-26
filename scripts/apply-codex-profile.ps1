param(
    [string] $CodexHome = (Join-Path $env:USERPROFILE '.codex'),
    [string] $ProfileRoot = (Join-Path (Get-Location) 'profiles\codex')
)

$ErrorActionPreference = 'Stop'

function Ensure-Directory {
    param([string] $Path)
    New-Item -ItemType Directory -Force -Path $Path | Out-Null
}

function Copy-DirectoryContents {
    param(
        [string] $Source,
        [string] $Destination
    )

    if (-not (Test-Path -LiteralPath $Source)) {
        return
    }

    Ensure-Directory $Destination

    Get-ChildItem -LiteralPath $Source -Force | Where-Object {
        $_.Name -ne '.gitkeep'
    } | ForEach-Object {
        $target = Join-Path $Destination $_.Name
        if (Test-Path -LiteralPath $target) {
            Remove-Item -LiteralPath $target -Recurse -Force
        }
        Copy-Item -LiteralPath $_.FullName -Destination $Destination -Recurse -Force
    }
}

if (-not (Test-Path -LiteralPath $ProfileRoot)) {
    throw "Profile root was not found: $ProfileRoot"
}

Ensure-Directory $CodexHome

Copy-DirectoryContents -Source (Join-Path $ProfileRoot 'skills') -Destination (Join-Path $CodexHome 'skills')
Copy-DirectoryContents -Source (Join-Path $ProfileRoot 'plugins') -Destination (Join-Path $CodexHome 'plugins')

$configSource = Join-Path $ProfileRoot 'config\config.toml'
if (Test-Path -LiteralPath $configSource) {
    Copy-Item -LiteralPath $configSource -Destination (Join-Path $CodexHome 'config.toml') -Force
}

Write-Output "Applied Codex profile from $ProfileRoot to $CodexHome"
Write-Output 'Restart Codex to pick up applied skills and plugins.'
