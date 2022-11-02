BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "GameOfLife" {
    It "Returns expected output" {
        GameOfLife | Should -Be "YOUR_EXPECTED_VALUE"
    }
}
