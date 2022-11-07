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

        WriteCells (GameOfLife 5 5) ((2, 3), (3, 3), (4, 3)) | Should -Be $result
        
    }
}

Describe "CellBirthLiveDead" {
    It "Can Determine Neighbor" {
        IsNeighbor (2, 3) (1, 2) | Should -BeTrue
        IsNeighbor (2, 3) (1, 3) | Should -BeTrue
        IsNeighbor (2, 3) (1, 4) | Should -BeTrue
        IsNeighbor (2, 3) (2, 2) | Should -BeTrue
        IsNeighbor (2, 3) (2, 4) | Should -BeTrue
        IsNeighbor (2, 3) (3, 2) | Should -BeTrue
        IsNeighbor (2, 3) (3, 3) | Should -BeTrue
        IsNeighbor (2, 3) (3, 4) | Should -BeTrue
        IsNeighbor (2, 3) (4, 4) | Should -BeFalse
        IsNeighbor (2, 3) (2, 3) | Should -BeFalse
    }
    
    It "Count Neighbor" {
        CountNeighbors (2, 3) @([Tuple]::Create(1, 2), [Tuple]::Create(4, 4)) | Should -Be 1
    }
}