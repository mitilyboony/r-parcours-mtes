[CmdletBinding()]
param(
  [ValidateSet("codex", "claude", "both")]
  [string]$Target = "both",
  [string]$Destination
)

$ErrorActionPreference = "Stop"
$source = Join-Path $PSScriptRoot "skills/r-parcours-mtes"
if (-not (Test-Path -LiteralPath (Join-Path $source "SKILL.md"))) { throw "SKILL.md introuvable dans $source" }

function Install-Skill([string]$Root) {
  $destinationPath = Join-Path $Root "r-parcours-mtes"
  New-Item -ItemType Directory -Force -Path $Root | Out-Null
  Copy-Item -Path (Join-Path $source "*") -Destination $destinationPath -Recurse -Force
  Write-Output "Skill installé dans $destinationPath"
}

if ($Destination) { Install-Skill $Destination }
else {
  if ($Target -in @("codex", "both")) { Install-Skill (Join-Path $HOME ".codex/skills") }
  if ($Target -in @("claude", "both")) { Install-Skill (Join-Path $HOME ".claude/skills") }
}
