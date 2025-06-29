# Contributing to CodeScaffold Pro

Thank you for your interest in contributing to CodeScaffold Pro! We welcome contributions from the community.

> 🚀 **Cross-platform**: This project is designed for any OS with PowerShell 7+ and Docker.

## 🖥️ Development Requirements

- **Windows, macOS, or Linux**
- **PowerShell 7+**
- **Git**
- **VSCode** (recommended)
- **Docker** (for testing Docker features)

## How to Contribute

### Reporting Issues

- Use the GitHub issue tracker to report bugs
- Include detailed steps to reproduce the issue
- Specify your OS and PowerShell version

### Submitting Changes

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test your changes thoroughly
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Development Setup

1. Clone the repository
2. Install Pester for testing: `Install-Module -Name Pester -Force -SkipPublisherCheck`
3. Run tests: `Invoke-Pester`
4. Test the main script: `./CodeScaffold_Pro.ps1`

### Code Style

- Follow PowerShell best practices and conventions
- Use proper cmdlet naming conventions (Verb-Noun)
- Include comment-based help for functions
- Maintain PowerShell 7+ compatibility
- Ensure proper error handling for cross-platform operations

### Testing

- Add Pester tests for new features
- Ensure all existing tests pass
- Test on different OSes when possible
- Validate UI dialogs work correctly
- Test Docker integration (if applicable)

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow

Thank you for contributing! 🚀
