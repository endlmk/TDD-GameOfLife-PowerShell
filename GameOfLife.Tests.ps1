using module ".\Pos.psm1"

BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "GameOfLife" {
    It "Shows board" {
        $result = 
@"
-----
-----
-----
-----
-----
"@

        GameOfLife 5 5 | Should -Be $result
        
    }

    It "Shows initial cells" {
        $result = 
@"
-----
-----
-***-
-----
-----
"@

        WriteCells (GameOfLife 5 5) @([Pos]::new(2, 3), [Pos]::new(3, 3), [Pos]::new(4, 3)) | Should -Be $result
        
    }
}

Describe "CellBirthLiveDead" {
    It "Can Determine Neighbor" {
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(1, 2)) | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(1, 3)) | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(1, 4)) | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(2, 2)) | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(2, 4)) | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(3, 2)) | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(3, 3)) | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(3, 4)) | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(4, 4)) | Should -BeFalse
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(2, 3)) | Should -BeFalse
    }
    
    It "Count Neighbor" {
        CountNeighbors ([Pos]::new(2, 3)) @([Pos]::new(1, 2), [Pos]::new(4, 4)) | Should -Be 1
    }
}