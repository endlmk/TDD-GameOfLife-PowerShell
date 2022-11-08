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
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(1, 2)) 5 5 | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(1, 3)) 5 5 | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(1, 4)) 5 5 | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(2, 2)) 5 5 | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(2, 4)) 5 5 | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(3, 2)) 5 5 | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(3, 3)) 5 5 | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(3, 4)) 5 5 | Should -BeTrue
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(4, 4)) 5 5 | Should -BeFalse
        IsNeighbor ([Pos]::new(2, 3)) ([Pos]::new(2, 3)) 5 5 | Should -BeFalse
    }
    
    It "Count Neighbor" {
        CountNeighbors ([Pos]::new(2, 3)) @([Pos]::new(1, 2), [Pos]::new(4, 4))  5 5 | Should -Be 1
        CountNeighbors ([Pos]::new(1, 3)) @([Pos]::new(1, 2), [Pos]::new(5, 4))  5 5 | Should -Be 2
    }

    It "Wrap edge" {
        WrapEdge ([Pos]::new(0, 0)) 5 5 | Should -Be ([Pos]::new(5, 5))
        WrapEdge ([Pos]::new(2, 3)) 5 5 | Should -Be ([Pos]::new(2, 3))
        WrapEdge ([Pos]::new(6, 6)) 5 5 | Should -Be ([Pos]::new(1, 1))
    }
}