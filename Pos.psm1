class Pos {
    [int] $X;
    [int] $Y;
    Pos([int]$x, [int]$y) {
        $this.X = $x
        $this.Y = $y
    }
    [bool] Equals([Object] $obj) {
        return ($this.X -eq $obj.X) -and ($this.Y -eq $obj.Y)
    }
}