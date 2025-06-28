#Requires -Version 5.1
<#
.SYNOPSIS
    CodeScaffold Pro - Advanced Python Project Generator & Bootstrapper for Windows
.DESCRIPTION
    🪟 WINDOWS ONLY: CodeScaffold Pro is designed exclusively for Windows environments and automates the creation and bootstrapping of modern Python projects with native Windows UI dialogs, dependency management, Docker support, and Git integration.

    Key Features:
    - 🎨 Windows 11-style native dialogs using Windows Forms
    - ✅ Tool validation for VSCode, Git for Windows, Docker Desktop, and GitHub CLI
    - 🐍 Two Python project templates: 'minimal' (with dev dependencies) and 'empty' (clean slate)
    - 📋 Intelligent requirements.txt generation with categorized dependencies
    - 🐳 Full Docker & DevContainer support for cross-platform development
    - 📝 Automated Git repository initialization and first commit
    - 🔧 Automated Docker build and Python environment setup
    - 🎯 Dynamic port selection to avoid conflicts
    - 🚀 Modern Windows workflow for rapid prototyping

.REQUIREMENTS
    WINDOWS ONLY - This script requires:
    - Windows 10/11 (or Windows Server 2016+)
    - Windows PowerShell 5.1+ (pre-installed on Windows 10/11)
    - Git for Windows (https://git-scm.com/download/win)
    - VSCode (https://code.visualstudio.com/)
    - Docker Desktop for Windows (https://docker.com/products/docker-desktop)
    - GitHub CLI (optional, https://cli.github.com/)

.PARAMETER SkipValidation
    Skip the validation of required Windows tools (VSCode, Git, Docker, GitHub CLI)

.PARAMETER Quiet  
    Suppress colored console output and run in quiet mode

.EXAMPLE
    .\CodeScaffold_Pro.ps1
    
    Runs the full interactive workflow with Windows dialogs for folder selection, 
    project naming, and template selection.

.EXAMPLE
    .\CodeScaffold_Pro.ps1 -SkipValidation
    
    Runs without validating that required tools are installed.

.EXAMPLE
    .\CodeScaffold_Pro.ps1 -Quiet
    
    Runs with minimal console output.

.EXAMPLE
    .\CodeScaffold_Pro.ps1 -SkipValidation -Quiet
    
    Runs with both tool validation skipped and minimal output.

.NOTES
    Platform: Windows Only
    PowerShell: Windows PowerShell 5.1+ (not PowerShell Core)
    UI Framework: Windows Forms (requires Windows desktop environment)
    
    This script uses Windows-specific features and cannot run on Linux or macOS.

.USE CASES
    - Rapid Python project scaffolding on Windows development machines
    - Standardized team project setup with Windows-native dialogs
    - Learning Python development in a Windows environment
    - Creating Docker-ready Python applications on Windows
    - Automating repetitive Windows-based development workflows
#>

param(
    [switch]$SkipValidation,
    [switch]$Quiet
)

# Add required assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationFramework

# Import modular components
. "$PSScriptRoot\UI.ps1"
. "$PSScriptRoot\Templates.ps1"
. "$PSScriptRoot\FileGeneration.ps1"
. "$PSScriptRoot\Main.ps1"
# Execute main function
Invoke-MainLogic -SkipValidation $SkipValidation -Quiet $Quiet