# CodeScaffold Pro: Project Workflow

## 1. Project Generation
- Run `.\CodeScaffold_Pro.ps1` in PowerShell
- Follow UI prompts:
  - Select project folder
  - Enter project name
  - Choose template and dependencies
- Script generates:
  - Project files (main.py, requirements.txt, README.md, .gitignore, Dockerfile, docker-compose.yml, .devcontainer/devcontainer.json)
  - Initializes Git
  - Builds and runs Docker container
  - Sets up Python venv and dependencies inside container
  - Prints a colorized summary table of all running Docker containers (with image/tag and base image/tag)

## 2. Development
- Open project in VS Code
- Use Dev Containers: "Reopen in Container" from the Command Palette (F1) for full-featured development
- The Python interpreter inside the container is automatically used by VS Code
- Linting, formatting, and requirements are pre-configured

## 3. Contribution Workflow
- Fork and clone the repository
- Create a new branch for your feature or fix
- Make changes and commit with clear messages
- Push to your fork and open a Pull Request
- Follow code review and CI feedback

## 4. Release & Maintenance
- Tag releases using Git
- Update documentation and templates as needed
- Review issues and PRs regularly

---
*For more, see README.md and PRD.md*
