# Contributing to CodeScaffold Pro

Thank you for your interest in contributing to CodeScaffold Pro! We welcome contributions from the Windows PowerShell community.

> 🪟 **Windows Only**: This project is designed exclusively for Windows environments and requires Windows PowerShell 5.1+

## 🖥️ Development Requirements

**This project requires Windows development environment:**

- **Windows 10/11** or Windows Server 2016+
- **Windows PowerShell 5.1+** (pre-installed on modern Windows)
- **Git for Windows**
- **VSCode** with PowerShell extension
- **Docker Desktop for Windows** (for testing Docker features)

## How to Contribute

### Reporting Issues

- Use the GitHub issue tracker to report bugs
- Include detailed steps to reproduce the issue
- Specify your **Windows version** and **PowerShell version**
- Mention if you're using Windows PowerShell vs PowerShell Core

### Submitting Changes

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes in the Windows environment
4. Test your changes thoroughly on Windows
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Development Setup

1. Clone the repository on a Windows machine
2. Install Pester for testing: `Install-Module -Name Pester -Force -SkipPublisherCheck`
3. Run tests: `Invoke-Pester`
4. Test the main script: `.\CodeScaffold_Pro.ps1 -SkipValidation`

### Code Style

- Follow PowerShell best practices and conventions
- Use proper cmdlet naming conventions (Verb-Noun)
- Include comment-based help for functions
- Maintain Windows PowerShell 5.1 compatibility
- Test Windows Forms dialogs on different Windows versions
- Ensure proper error handling for Windows-specific operations

### Testing

- Add Pester tests for new features
- Ensure all existing tests pass on Windows
- Test on different Windows versions when possible (Windows 10/11)
- Validate Windows Forms dialogs work correctly
- Test Docker integration on Windows (if applicable)

## Platform-Specific Considerations

### Windows PowerShell vs PowerShell Core

- This project targets **Windows PowerShell 5.1** specifically
- Windows Forms require Windows PowerShell (not supported in PowerShell Core on Linux/macOS)
- Ensure compatibility with Windows PowerShell execution policies

### Windows-Specific Features

- Windows Forms dialogs and UI components
- Windows file system paths and directory structures
- Windows Docker Desktop integration
- Windows-specific Git configuration

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow

Thank you for contributing! 🚀
