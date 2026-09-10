<#
.SYNOPSIS
  Create a new blog post in content/posts/.
.EXAMPLE
  ./scripts/new-post.ps1 "Moya novaya statya"
  ./scripts/new-post.ps1 -Title "Zagolovok" -Slug "my-post"
#>
param(
  [Parameter(Position = 0, Mandatory = $true)]
  [string]$Title,
  [string]$Slug
)

$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
Set-Location $root

# Russian -> Latin transliteration, indexed by (codepoint - 0x0430), covering а..я
$tr = @(
  'a','b','v','g','d','e','zh','z','i','y','k','l','m','n','o','p',
  'r','s','t','u','f','h','ts','ch','sh','sch','','y','','e','yu','ya'
)

if (-not $Slug) {
  $sb = [System.Text.StringBuilder]::new()
  foreach ($ch in $Title.ToLower().ToCharArray()) {
    $code = [int][char]$ch
    if ($code -ge 0x0430 -and $code -le 0x044F) {
      [void]$sb.Append($tr[$code - 0x0430])
    }
    elseif ($code -eq 0x0451) { [void]$sb.Append('e') }   # yo
    elseif ("$ch" -match '[a-z0-9]') { [void]$sb.Append($ch) }
    elseif ($ch -eq ' ' -or $ch -eq '-' -or $ch -eq '_') { [void]$sb.Append('-') }
  }
  $Slug = ($sb.ToString() -replace '-+', '-').Trim('-')
}

if (-not $Slug) { throw "Could not build a slug from title; pass -Slug explicitly." }

$rel = "posts/$Slug.md"
& hugo new content $rel
if ($LASTEXITCODE -ne 0) { throw "hugo new content failed" }

$path = Join-Path $root "content/$rel"
$text = [System.IO.File]::ReadAllText($path)
$text = [regex]::Replace($text, '(?m)^title = .*$', 'title = "' + ($Title -replace '"', '\"') + '"')
[System.IO.File]::WriteAllText($path, $text, (New-Object System.Text.UTF8Encoding $false))

Write-Host ""
Write-Host "Created: content/$rel" -ForegroundColor Green
Write-Host "Next: write the text, set draft = false, then run 'hugo server -D' to preview."
