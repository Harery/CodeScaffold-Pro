# CodeScaffold Pro

[![CI](https://github.com/Harery/CodeScaffold-Pro/actions/workflows/ci.yml/badge.svg)](https://github.com/Harery/CodeScaffold-Pro/actions/workflows/ci.yml)
[![Platform](https://img.shields.io/badge/platform-Cross--platform-blue.svg)](https://www.docker.com/)
[![PowerShell](https://img.shields.io/badge/PowerShell-7%2B-blue.svg)](https://docs.microsoft.com/powershell/)

> 🚀 **Cross-platform**: This tool runs on any OS with PowerShell 7+ and Docker.

A modular, robust project generator and bootstrapper for containerized development. Features an interactive checkbox UI for selecting Ubuntu-based OS features (Apt Utils, Locales, SSH, Python, Node.js, UFW, Fail2Ban) and generates a best-practice Dockerfile and scaffolding for modern development.

## 🖥️ System Requirements

- **Any OS** (Windows, macOS, Linux)
- **PowerShell 7+**
- **Docker**
- **VSCode** (recommended for DevContainer support)
- **Git**

> **Note:** To use UFW and iptables-based features, you must run your container with the `--privileged` flag:
> ```sh
> docker run --privileged -p 8000:8000 <image>
> ```

## ✨ Features

- 🖼️ Modern cross-platform UI (checkbox dialog for OS features)
- 🐧 Ubuntu-based Dockerfile generation with robust RUN block formatting
- 🧩 Modular PowerShell codebase: `UI.ps1`, `Templates.ps1`, `FileGeneration.ps1`, `Main.ps1`
- 🛠️ OS feature selection: Apt Utils, Locales, SSH, Python, Node.js, UFW, Fail2Ban
- 🐳 Docker & DevContainer support for containerized development
- 📝 Git integration with automatic initialization
- ✅ Robust validation and error handling
- 🧪 Pester tests for core logic
- 🚀 CI/CD ready (GitHub Actions)

## 🚀 Quick Start

```powershell
# Clone the repository
git clone https://github.com/Harery/CodeScaffold-Pro.git
cd CodeScaffold-Pro

# Run the generator
./CodeScaffold_Pro.ps1
```

### Workflow

1. **Folder selection** - Choose where to create your project
2. **Project naming** - Enter a valid project name
3. **OS feature selection** - Check desired Ubuntu features (Apt Utils, Locales, SSH, Python, Node.js, UFW, Fail2Ban)
4. **Project generation** - Generates Dockerfile, docker-compose.yml, .devcontainer, README, .gitignore, and more
5. **Ready to build** - Open in VSCode, build Docker image, and start developing

## 🐧 OS Feature Options

- **Apt Utils**: Installs apt-utils for improved package management
- **Locales**: Installs and configures en_US.UTF-8 and ar_SA.UTF-8
- **SSH**: Installs and configures OpenSSH server
- **Python**: Installs Python 3, pip, venv, and best-practice Python tools in a virtual environment
- **Node.js**: Installs Node.js LTS via NodeSource
- **UFW**: Installs and configures Uncomplicated Firewall (enabled at runtime)
- **Fail2Ban**: Installs Fail2Ban for security

## 🧪 Testing

- Pester tests are located in the `tests/` directory
- Run all tests: `Invoke-Pester`

## 🚀 CI/CD

- GitHub Actions workflow in `.github/workflows/ci.yml`
- Automated testing on Ubuntu runners
- PowerShell syntax validation and Pester test execution

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built for cross-platform, containerized development
- Inspired by modern project scaffolding tools

---

*Updated for Ubuntu/Docker, OS feature selection, and cross-platform support.*
