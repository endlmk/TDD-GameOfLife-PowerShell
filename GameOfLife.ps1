using module ".\Pos.psm1"

using namespace System.Collections.Generic
function GameOfLife($width, $height, $cells) {
    $board = [List[List[char]]]::new()
    for($i = 0; $i -lt $height; ++$i) {
        $board.Add([List[char]]::new('-' * 5))
    }

    foreach($p in $cells) {
        $board[$p.Y - 1][$p.X - 1] = '*'
    }

    $boardStr = ($board | ForEach-Object { [String]::new($_.ToArray()) }) -join "`r`n"
    $nextGen = NextGeneration $cells $width $height
    ($boardStr, $nextGen)
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

function IsAlive([Pos]$p, $cells, [Int]$width, [Int]$height) {
    $cellsCount = CountNeighbors $p $cells $width $height
    if($cells -contains $p) {
        ($cellsCount -eq 2) -or ($cellsCount -eq 3)
    }
    else {
        $cellsCount -eq 3
    }
}

function NextGeneration($cells, [Int]$width, [Int]$height) {
    $allPos = @()
    for($y = 1; $y -le $height; ++$y) {
        for($x = 1; $x -le $width; ++$x) {
            $allPos += [Pos]::new($x, $y)
        }
    }

    $allPos | Where-Object { IsAlive $_ $cells $width $height }
}

function GameOfLifeLoop($width, $height, $cells) {
    $result = GameOfLife $width $height $cells
    for(;;) {
        Clear-Host
        $result[0]
        $result = GameOfLife $width $height $result[1]
        Start-Sleep -Milliseconds 100
    }
}

# GameOfLifeLoop 5 5 @([Pos]::new(2, 3), [Pos]::new(3, 3), [Pos]::new(4, 3))
