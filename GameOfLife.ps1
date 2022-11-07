
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

    foreach($cell in $cells) {
        $array2[$cell[1] - 1][$cell[0] - 1] = '*'
    }
    $array3 = [List[String]]::new()
    foreach($rows in $array2) {
        $array3.Add([String]::new($rows.ToArray()))   
    }
    $array3 -join "`r`n"
}

function IsNeighbor($cell1, $cell2) {
    $x1 = $cell1[0]
    $y1 = $cell1[1]
    $x2 = $cell2[0]
    $y2 = $cell2[1]
    $xdiff = [Math]::Abs($x1 - $x2)
    $ydiff = [Math]::Abs($y1 - $y2)

    return ($xdiff -le 1) -and ($ydiff -le 1) -and (($xdiff -ne 0) -or ($ydiff -ne 0))
}

function CountNeighbors($pos, $cells) {
    $neighbors = ($cells | Where-Object { IsNeighbor $pos $_ })
    $neighbors.Count
}