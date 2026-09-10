<#
.SYNOPSIS
  Create a new blog post in content/posts/.
.DESCRIPTION
  The title can be in any language. The URL slug must be given explicitly in
  Latin letters (-Slug) unless the title itself is already ASCII.
.EXAMPLE
  ./scripts/new-post.ps1 "Зачем я пишу свой язык" -Slug "why-a-data-language"
  ./scripts/new-post.ps1 "Hello world"
#>
param(
  [Parameter(Position = 0, Mandatory = $true)]
  [string]$Title,
  [string]$Slug
)

$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
Set-Location $root

if (-not $Slug) {
  if ($Title -match '^[\x20-\x7E]+$') {
    $Slug = $Title.ToLower()
  }
  else {
    throw "Non-ASCII title: pass an English slug explicitly, e.g. -Slug ""my-post""."
  }
}

$Slug = $Slug.ToLower() -replace '[^a-z0-9]+', '-'
$Slug = $Slug.Trim('-')
if (-not $Slug) { throw "Slug is empty after normalization; pass -Slug explicitly." }

$rel = "posts/$Slug.md"
if (Test-Path (Join-Path $root "content/$rel")) { throw "content/$rel already exists." }

& hugo new content $rel
if ($LASTEXITCODE -ne 0) { throw "hugo new content failed" }

$path = Join-Path $root "content/$rel"
$text = [System.IO.File]::ReadAllText($path)
$text = [regex]::Replace($text, '(?m)^title = .*$', 'title = "' + ($Title -replace '"', '\"') + '"')
[System.IO.File]::WriteAllText($path, $text, (New-Object System.Text.UTF8Encoding $false))

Write-Host ""
Write-Host "Created: content/$rel" -ForegroundColor Green
Write-Host "Next: write the text, set draft = false, then run 'hugo server -D' to preview."
