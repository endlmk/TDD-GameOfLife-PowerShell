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
}
