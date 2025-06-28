# CodeScaffold Pro

[![CI](https://github.com/Harery/CodeScaffold-Pro/actions/workflows/ci.yml/badge.svg)](https://github.com/Harery/CodeScaffold-Pro/actions/workflows/ci.yml)
[![Platform](https://img.shields.io/badge/platform-Windows-blue.svg)](https://www.microsoft.com/windows)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)](https://docs.microsoft.com/powershell/)

> 🪟 **Windows Only**: This tool is designed exclusively for Windows operating systems and requires Windows PowerShell 5.1+

A modular, robust Python project generator and bootstrapper for **Windows PowerShell**. Features interactive Windows 11-style dialogs and supports two Python templates:

- **`minimal`**: Best-practice dev dependencies for professional development
- **`empty`**: Clean slate with no dependencies

## 🖥️ System Requirements

**⚠️ WINDOWS ONLY** - This project requires:
- **Windows 10/11** (Windows Server 2016+ also supported)
- **Windows PowerShell 5.1+** (pre-installed on Windows 10/11)
- **Administrator privileges** may be required for some operations

### Required Tools
- **VSCode** - Code editor with DevContainer support
- **Git for Windows** - Version control
- **Docker Desktop for Windows** - Container support
- **GitHub CLI (optional)** - Enhanced Git operations

## ✨ Features
- 🎨 **Windows 11-style UI** - Native Windows Forms dialogs
- 📦 **Modular PowerShell codebase** - `UI.ps1`, `Templates.ps1`, `FileGeneration.ps1`, `Main.ps1`
- 🐍 **Two Python templates**: `minimal` and `empty` only
- 📋 **Automated requirements.txt** generation with categorized dependencies
- 🐳 **Docker & DevContainer** support for cross-platform development
- 📝 **Git integration** with automatic initialization and first commit
- 🔧 **Automated setup** - Docker build and Python environment configuration
- ✅ **Robust validation** - Input validation and error handling
- 🧪 **Pester tests** - Comprehensive test suite
- 🚀 **CI/CD ready** - GitHub Actions workflow

## 🚀 Quick Start

**Windows PowerShell only:**

```powershell
# Clone the repository
git clone https://github.com/Harery/CodeScaffold-Pro.git
cd CodeScaffold-Pro

# Run the generator
.\CodeScaffold_Pro.ps1
```

### Command Line Options

```powershell
# Basic usage
.\CodeScaffold_Pro.ps1

# Skip tool validation
.\CodeScaffold_Pro.ps1 -SkipValidation

# Quiet mode (less output)
.\CodeScaffold_Pro.ps1 -Quiet

# Combined options
.\CodeScaffold_Pro.ps1 -SkipValidation -Quiet
```

The script will display Windows dialogs to guide you through:

1. **Folder selection** - Choose where to create your project
2. **Project naming** - Enter a valid Python project name  
3. **Template selection** - Choose `minimal` or `empty`
4. **Dependency customization** - Add optional dependencies

## 📋 Available Templates

### minimal

- **Description**: Minimal Python project with best-practice dev dependencies
- **Dependencies**: `setuptools`, `pre-commit`, `mypy`, `rich`, `pipenv`, `virtualenv`, `venv`, `loguru`, `python-dotenv`, `black`, `pip`
- **Use Case**: Professional development with linting, formatting, and environment management

### empty

- **Description**: Minimal empty project with no dependencies
- **Dependencies**: *(none)*
- **Use Case**: Clean slate for custom setups or learning

## 🧪 Testing

- Pester tests are located in the `tests/` directory
- Run all tests: `Invoke-Pester`
- Tests validate PowerShell syntax and core functionality

## 🚀 CI/CD

- GitHub Actions workflow in `.github/workflows/ci.yml`
- Automated testing on Windows runners
- PowerShell syntax validation and Pester test execution
- Markdown linting for documentation quality

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built for Windows PowerShell ecosystem
- Designed for Python development workflow
- Inspired by modern project scaffolding tools

---

**Made with 💙 for Windows developers**

---
*Updated for modular structure, CI, and new template logic.*
