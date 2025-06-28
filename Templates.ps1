# Templates.ps1 - Template definitions for CodeScaffold Pro

function Get-PythonTemplates {
    return @{
        "minimal" = @{
            description  = "Minimal Python project with best-practice dev dependencies"
            dependencies = @(
                "setuptools", "pre-commit", "mypy", "rich", "pipenv", "virtualenv", "venv", "loguru", "python-dotenv", "black", "pip"
            )
        }
        "empty" = @{
            description  = "Minimal empty project"
            dependencies = @()
        }
    }
}
