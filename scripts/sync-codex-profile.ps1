param(
    [string] $CodexHome = (Join-Path $env:USERPROFILE '.codex'),
    [string] $ProfileRoot = (Join-Path (Get-Location) 'profiles\codex')
)

$ErrorActionPreference = 'Stop'

function Ensure-Directory {
    param([string] $Path)
    New-Item -ItemType Directory -Force -Path $Path | Out-Null
}

function Copy-DirectoryClean {
    param(
        [string] $Source,
        [string] $Destination,
        [string[]] $ExcludeNames = @()
    )

    if (-not (Test-Path -LiteralPath $Source)) {
        return
    }

    if (Test-Path -LiteralPath $Destination) {
        $resolved = Resolve-Path -LiteralPath $Destination
        $profileResolved = Resolve-Path -LiteralPath $ProfileRoot
        if (-not $resolved.Path.StartsWith($profileResolved.Path, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "Refusing to delete destination outside profile root: $Destination"
        }
        Remove-Item -LiteralPath $Destination -Recurse -Force
    }

    Ensure-Directory $Destination

    Get-ChildItem -LiteralPath $Source -Force | Where-Object {
        $ExcludeNames -notcontains $_.Name
    } | ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination $Destination -Recurse -Force
    }
}

function Get-PluginManifest {
    param([string] $PluginPath)

    $pluginJsonPath = Join-Path $PluginPath '.codex-plugin\plugin.json'
    if (-not (Test-Path -LiteralPath $pluginJsonPath)) {
        return $null
    }

    $pluginJson = Get-Content -Raw -LiteralPath $pluginJsonPath | ConvertFrom-Json
    $skillNames = @()

    if ($pluginJson.skills) {
        $skillsPath = Join-Path $PluginPath $pluginJson.skills
        if (Test-Path -LiteralPath $skillsPath) {
            $skillNames = @(Get-ChildItem -LiteralPath $skillsPath -Directory | Sort-Object Name | Select-Object -ExpandProperty Name)
        }
    }

    [ordered]@{
        name = $pluginJson.name
        version = $pluginJson.version
        path = (Split-Path -Leaf $PluginPath)
        skills = $skillNames
    }
}

if (-not (Test-Path -LiteralPath $CodexHome)) {
    throw "Codex home was not found: $CodexHome"
}

Ensure-Directory $ProfileRoot

$skillsSource = Join-Path $CodexHome 'skills'
$skillsDestination = Join-Path $ProfileRoot 'skills'
Copy-DirectoryClean -Source $skillsSource -Destination $skillsDestination -ExcludeNames @('.system', 'codex-primary-runtime')

$pluginsSource = Join-Path $CodexHome 'plugins'
$pluginsDestination = Join-Path $ProfileRoot 'plugins'
Copy-DirectoryClean -Source $pluginsSource -Destination $pluginsDestination -ExcludeNames @('cache')

$configDestination = Join-Path $ProfileRoot 'config'
Ensure-Directory $configDestination

$configSource = Join-Path $CodexHome 'config.toml'
if (Test-Path -LiteralPath $configSource) {
    Copy-Item -LiteralPath $configSource -Destination (Join-Path $configDestination 'config.toml') -Force
}

$manifest = [ordered]@{
    agent = 'codex'
    schemaVersion = 1
    excluded = @(
        'auth.json',
        'sessions/',
        'history.jsonl',
        '*.sqlite',
        '*.sqlite-shm',
        '*.sqlite-wal',
        'log/',
        'tmp/',
        '.tmp/',
        'plugins/cache/',
        'skills/.system/',
        'skills/codex-primary-runtime/'
    )
    plugins = @()
    skills = [ordered]@{
        standalone = @()
        fromPlugins = @()
    }
}

if (Test-Path -LiteralPath $skillsDestination) {
    $manifest.skills.standalone = @(Get-ChildItem -LiteralPath $skillsDestination -Directory | Sort-Object Name | Select-Object -ExpandProperty Name)
}

if (Test-Path -LiteralPath $pluginsDestination) {
    $pluginManifests = @()
    Get-ChildItem -LiteralPath $pluginsDestination -Directory -Force | Sort-Object Name | ForEach-Object {
        $pluginManifest = Get-PluginManifest -PluginPath $_.FullName
        if ($pluginManifest) {
            $pluginManifests += $pluginManifest
            foreach ($skillName in $pluginManifest.skills) {
                $manifest.skills.fromPlugins += [ordered]@{
                    name = $skillName
                    plugin = $pluginManifest.name
                }
            }
        }
        else {
            $pluginManifests += [ordered]@{
                name = $_.Name
                version = $null
                path = $_.Name
                skills = @()
            }
        }
    }
    $manifest.plugins = $pluginManifests
}

$manifest | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath (Join-Path $ProfileRoot 'manifest.json') -Encoding UTF8

Write-Output "Synced Codex profile to $ProfileRoot"
