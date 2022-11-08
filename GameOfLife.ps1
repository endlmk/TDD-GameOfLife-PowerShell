using module ".\Pos.psm1"

using namespace System.Collections.Generic
function GameOfLife($width, $height) {
    $board = @()
    for($i = 0; $i -lt $height; ++$i) {
        $board += "-" * $width
    }
    $board -join "`r`n"
}

function WriteCells($board, $cells) {
    $array = $board.Split("`r`n");
    $array2 = [List[List[char]]]::new()
    $array.ForEach({ $array2.Add($_.ToCharArray()) })

    foreach($p in $cells) {
        $array2[$p.Y - 1][$p.X - 1] = '*'
    }
    $array3 = [List[String]]::new()
    foreach($rows in $array2) {
        $array3.Add([String]::new($rows.ToArray()))   
    }
    $array3 -join "`r`n"
}

function IsNeighbor([Pos]$p1, [Pos]$p2) {
    $x1 = $p1.X
    $y1 = $p1.Y
    $x2 = $p2.X
    $y2 = $p2.Y
    $xdiff = [Math]::Abs($x1 - $x2)
    $ydiff = [Math]::Abs($y1 - $y2)

    return ($xdiff -le 1) -and ($ydiff -le 1) -and (($xdiff -ne 0) -or ($ydiff -ne 0))
}

function CountNeighbors([Pos]$pos, $cells) {
    $neighbors = ($cells | Where-Object { IsNeighbor $pos $_ })
    $neighbors.Count
}