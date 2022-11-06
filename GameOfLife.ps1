
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
