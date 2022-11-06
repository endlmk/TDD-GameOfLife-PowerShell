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
