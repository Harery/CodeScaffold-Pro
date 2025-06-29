# Product Requirements Document (PRD)
# CodeScaffold Pro - Cross-Platform Project Generator

## Overview

CodeScaffold Pro is a modular, cross-platform project generator and bootstrapper for containerized development. It leverages PowerShell 7+ and Docker to provide a professional, OS-agnostic development experience with robust Ubuntu-based scaffolding.

### Platform Requirements

- **Target Platform**: Any OS (Windows, macOS, Linux)
- **PowerShell Version**: PowerShell 7+
- **UI Framework**: Cross-platform PowerShell dialogs
- **Dependencies**: Git, VSCode, Docker

## Supported Templates

The tool supports flexible Ubuntu-based project scaffolding via OS feature selection:

- **Apt Utils**: Improved package management
- **Locales**: en_US.UTF-8, ar_SA.UTF-8
- **SSH**: OpenSSH server
- **Python**: Python 3, pip, venv, and best-practice Python tools (in a virtual environment)
- **Node.js**: Node.js LTS via NodeSource
- **UFW**: Uncomplicated Firewall (enabled at runtime)
- **Fail2Ban**: Security hardening

## Core Features

### Cross-Platform Experience

- Modern, cross-platform checkbox dialog for OS feature selection
- Real-time input validation and error messaging
- OS-agnostic file path handling and directory operations

### Modular PowerShell Architecture

- **UI.ps1**: Dialog management and user interface
- **Templates.ps1**: Template definitions and configuration
- **FileGeneration.ps1**: File creation and content generation
- **Main.ps1**: Core execution logic and orchestration
- **CodeScaffold_Pro.ps1**: Main entry point with module imports

### Development Workflow Integration

- Automated validation of required tools (Git, VSCode, Docker)
- Intelligent Dockerfile and project scaffolding generation
- Git repository initialization
- Automated Docker build for Ubuntu-based containers

## Template Details

- **OS Feature Selection**: User chooses which Ubuntu features to include; Dockerfile and supporting files are generated accordingly.

## Onboarding & Usage

- Run `CodeScaffold_Pro.ps1` to launch the UI and select desired OS features.
- Follow prompts for folder, project name, and features.
- All generated projects follow the new modular structure and template logic.

## Testing & CI

- Pester tests cover template logic and file generation.
- GitHub Actions CI runs tests and enforces robust error handling.

---
See README.md for usage and contribution details. Contact: your-org/project-maintainers
