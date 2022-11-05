function GameOfLife($width, $height) {
    $board = @()
    for($i = 0; $i -lt $height; ++$i) {
        $board += "-" * $width
    }
    $board -join "`r`n"
}
