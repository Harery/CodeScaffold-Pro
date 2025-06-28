# Product Requirements Document (PRD)
# CodeScaffold Pro - Windows Python Project Generator

## Overview

CodeScaffold Pro is a **Windows-exclusive**, modular Python project generator and bootstrapper designed for Windows PowerShell environments. It leverages native Windows UI components to provide a professional development experience.

### Platform Requirements
- **Target Platform**: Windows 10/11, Windows Server 2016+
- **PowerShell Version**: Windows PowerShell 5.1+ (not PowerShell Core)
- **UI Framework**: Windows Forms (Windows desktop environment required)
- **Dependencies**: Git for Windows, VSCode, Docker Desktop for Windows

## Supported Templates

The tool supports exactly **two Python templates** to maintain simplicity:

- **minimal**: Professional development template with curated dev dependencies
- **empty**: Clean slate template with no pre-installed dependencies

## Core Features

### Windows-Native Experience
- 🎨 Windows 11-style native dialogs using System.Windows.Forms
- 🖱️ Point-and-click folder selection with Windows folder browser
- ⌨️ Real-time input validation with Windows-style error messaging
- 🎯 Windows-specific file path handling and directory operations

### Modular PowerShell Architecture
- **UI.ps1**: Windows Forms dialog management and user interface
- **Templates.ps1**: Template definitions and configuration
- **FileGeneration.ps1**: File creation and content generation
- **Main.ps1**: Core execution logic and orchestration
- **CodeScaffold_Pro.ps1**: Main entry point with module imports

### Development Workflow Integration
- ✅ Automated validation of Windows-specific tools (Git for Windows, VSCode, Docker Desktop)
- 📋 Intelligent requirements.txt generation with dependency categorization
- 🐳 Docker & DevContainer support for Windows development
- 📝 Git repository initialization with Windows-compatible paths
- 🔧 Automated Docker build with Windows container support

## Template Details

### minimal
- Description: Minimal Python project with best-practice dev dependencies
- Dependencies: `setuptools`, `pre-commit`, `mypy`, `rich`, `pipenv`, `virtualenv`, `venv`, `loguru`, `python-dotenv`, `black`, `pip`

### empty
- Description: Minimal empty project
- Dependencies: *(none)*

## Onboarding & Usage
- Run `CodeScaffold_Pro.ps1` to launch the UI and select a template (`minimal` or `empty`).
- Follow prompts for folder, project name, and (optionally) extra dependencies.
- All generated projects follow the new modular structure and template logic.

## Testing & CI
- Pester tests cover template logic and file generation.
- GitHub Actions CI runs tests and enforces robust error handling.

---
*See README.md for usage and contribution details. Contact: your-org/project-maintainers*
