Add-Type -AssemblyName System.Drawing
$ErrorActionPreference = 'Stop'
$culture = [System.Globalization.CultureInfo]::InvariantCulture

function Get-WordPath([string]$label, [string]$familyName, [single]$size) {
    $shape = New-Object System.Drawing.Drawing2D.GraphicsPath
    $family = New-Object System.Drawing.FontFamily($familyName)
    $shape.AddString($label, $family, [int][System.Drawing.FontStyle]::Bold, $size, [System.Drawing.PointF]::new(0, 0), [System.Drawing.StringFormat]::GenericTypographic)
    $family.Dispose()
    return $shape
}

function ConvertTo-SvgPath($shape, [double]$offsetX, [double]$offsetY) {
    $points = $shape.PathPoints
    $types = $shape.PathTypes
    $commands = New-Object 'System.Collections.Generic.List[string]'
    for ($i = 0; $i -lt $points.Length; $i++) {
        $kind = $types[$i] -band 7
        $x = ($points[$i].X + $offsetX).ToString('0.###', $culture)
        $y = ($points[$i].Y + $offsetY).ToString('0.###', $culture)
        if ($kind -eq 0) { $commands.Add("M$x $y") }
        elseif ($kind -eq 1) { $commands.Add("L$x $y") }
        elseif ($kind -eq 3) {
            $coords = @("$x $y")
            for ($j = 1; $j -le 2; $j++) {
                $i++
                $x = ($points[$i].X + $offsetX).ToString('0.###', $culture)
                $y = ($points[$i].Y + $offsetY).ToString('0.###', $culture)
                $coords += "$x $y"
            }
            $commands.Add('C' + ($coords -join ' '))
        }
        if (($types[$i] -band 128) -ne 0) { $commands.Add('Z') }
    }
    return $commands -join ' '
}

# Classic serif direction: ivory lettering, amber midpoint and Korean name.
$en = Get-WordPath 'En' 'Times New Roman' 80
$core = Get-WordPath 'Core' 'Times New Roman' 80
$korean = Get-WordPath '인코어' 'Malgun Gothic' 28
$enBounds = $en.GetBounds()
$coreBounds = $core.GetBounds()
$koreanBounds = $korean.GetBounds()
$capHeight = [Math]::Max($enBounds.Height, $coreBounds.Height)
$dotRadius = 4.6
$dotX = 4 + $enBounds.Width + 9
$coreX = $dotX + $dotRadius + 6
$koreanX = $coreX + $coreBounds.Width + 15
$width = [Math]::Ceiling($koreanX + $koreanBounds.Width + 4)
$height = [Math]::Ceiling($capHeight + 8)
$dotY = 4 + $capHeight / 2
$enPath = ConvertTo-SvgPath $en (4 - $enBounds.X) (4 + $capHeight - $enBounds.Height - $enBounds.Y)
$corePath = ConvertTo-SvgPath $core ($coreX - $coreBounds.X) (4 + $capHeight - $coreBounds.Height - $coreBounds.Y)
$koreanPath = ConvertTo-SvgPath $korean ($koreanX - $koreanBounds.X) (4 + ($capHeight - $koreanBounds.Height) / 2 - $koreanBounds.Y)
$dotXText = $dotX.ToString('0.###', $culture)
$dotYText = $dotY.ToString('0.###', $culture)
$svg = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 $width $height" role="img" aria-labelledby="title">
  <title id="title">En·Core 인코어</title>
  <path fill="#F3EBDD" d="$enPath"/>
  <circle cx="$dotXText" cy="$dotYText" r="4.6" fill="#F5B849"/>
  <path fill="#F3EBDD" d="$corePath"/>
  <path fill="#F5B849" d="$koreanPath"/>
</svg>
"@
$destination = Join-Path $PSScriptRoot '../assets/brand/encore-classic.svg'
[System.IO.File]::WriteAllText($destination, $svg, [System.Text.UTF8Encoding]::new($false))
$en.Dispose()
$core.Dispose()
$korean.Dispose()
Write-Output "Created classic wordmark: $width x $height"
