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

function IsNeighbor([Pos]$p1, [Pos]$p2, [Int]$width, [Int]$height) {
    $x1 = $p1.X
    $y1 = $p1.Y

    $neighbs = @(
        ([Pos]::new($x1 - 1, $y1 - 1))
        ([Pos]::new($x1 - 1, $y1))
        ([Pos]::new($x1 - 1, $y1 + 1)) 
        ([Pos]::new($x1, $y1 - 1))
        ([Pos]::new($x1, $y1 + 1))
        ([Pos]::new($x1 + 1, $y1 - 1))
        ([Pos]::new($x1 + 1, $y1))
        ([Pos]::new($x1 + 1, $y1 + 1))
    )
    $wrapNegihbs = $neighbs | ForEach-Object { WrapEdge $_ $width $height }
    return $wrapNegihbs -contains $p2
}

function CountNeighbors([Pos]$pos, $cells, [Int]$width, [Int]$height) {
    $neighbors = ($cells | Where-Object { IsNeighbor $pos $_ $width $height })
    $neighbors.Count
}

function remainder([Int]$a, [Int]$b) {
    $a - [int][Math]::floor($a / $b) * $b
}

function WrapEdge([Pos]$pos, [Int]$width, [Int]$height) {
    [Pos]::new((remainder ($pos.X - 1) $width) + 1, (remainder ($pos.Y - 1) $height) + 1)
}
