param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $Arguments
)

$ErrorActionPreference = 'Stop'

$edgePath = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'
if (-not (Test-Path -LiteralPath $edgePath)) {
    $edgePath = 'C:\Program Files\Microsoft\Edge\Application\msedge.exe'
}

if (-not (Test-Path -LiteralPath $edgePath)) {
    throw 'Microsoft Edge executable was not found in the standard install locations.'
}

$npx = Get-Command npx -ErrorAction SilentlyContinue
if (-not $npx) {
    throw 'npx is required. Install Node.js/npm, then retry.'
}

$cliArgs = @('--yes', '--package', '@playwright/cli', 'playwright-cli')

if ($Arguments.Count -gt 0 -and $Arguments[0] -eq 'open') {
    $hasBrowser = $false
    foreach ($arg in $Arguments) {
        if ($arg -eq '--browser' -or $arg.StartsWith('--browser=')) {
            $hasBrowser = $true
            break
        }
    }

    if (-not $hasBrowser) {
        $cliArgs += @('open')
        if ($Arguments.Count -gt 1) {
            $cliArgs += $Arguments[1..($Arguments.Count - 1)]
        }
        $cliArgs += @('--browser', 'msedge')
    }
    else {
        $cliArgs += $Arguments
    }
}
else {
    $cliArgs += $Arguments
}

& npx @cliArgs
