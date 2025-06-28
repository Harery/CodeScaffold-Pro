# Tests for CodeScaffold Pro
# These tests verify the core functionality of the Python project generator

BeforeAll {
    # Import the modules
    . "$PSScriptRoot\..\Templates.ps1"
    . "$PSScriptRoot\..\FileGeneration.ps1"
}

Describe "Template Functions" {
    Context "Get-PythonTemplates" {
        It "Should return template definitions" {
            $templates = Get-PythonTemplates
            $templates | Should -Not -BeNullOrEmpty
            $templates.Keys | Should -Contain "minimal"
            $templates.Keys | Should -Contain "empty"
        }

        It "Should have required template properties" {
            $templates = Get-PythonTemplates
            $minimal = $templates["minimal"]
            $minimal | Should -HaveProperty "description"
            $minimal | Should -HaveProperty "dependencies"
        }
    }
}

Describe "File Generation Functions" {
    Context "New-MainPy" {
        It "Should generate Python main file" {
            $content = New-MainPy "minimal"
            $content | Should -Not -BeNullOrEmpty
            $content | Should -Match "def main"
        }
    }

    Context "New-RequirementsTxt" {
        It "Should generate requirements file with dependencies" {
            $deps = @("setuptools", "black", "pip")
            $content = New-RequirementsTxt $deps
            $content | Should -Not -BeNullOrEmpty
            $content | Should -Match "setuptools"
        }

        It "Should handle empty dependencies" {
            $content = New-RequirementsTxt @()
            $content | Should -Match "Add your project dependencies here"
        }
    }

    Context "New-Dockerfile" {
        It "Should generate Dockerfile" {
            $content = New-Dockerfile "minimal"
            $content | Should -Not -BeNullOrEmpty
            $content | Should -Match "FROM python:3.11-slim"
        }
    }
}
