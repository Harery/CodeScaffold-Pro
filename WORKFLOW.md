# CodeScaffold Pro: Project Workflow

## 1. Project Generation

- Run `./CodeScaffold_Pro.ps1` in PowerShell 7+
- Follow UI prompts:
  - Select project folder
  - Enter project name
  - Select Ubuntu OS features (Apt Utils, Locales, SSH, Python, Node.js, UFW, Fail2Ban) via checkboxes
- Script generates:
  - Project files (Dockerfile, docker-compose.yml, .devcontainer/devcontainer.json, README.md, .gitignore, etc.)
  - Initializes Git
  - Ready for Docker build and development

> **Note:** To use UFW and iptables-based features, you must run your container with the `--privileged` flag:
>
> ```sh
> docker run --privileged -p 8000:8000 <image>
> ```

## 2. Development

- Open project in VS Code
- Use Dev Containers: "Reopen in Container" for full-featured development
- The Ubuntu-based Python/Node.js interpreter inside the container is automatically used by VS Code
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

For more, see README.md and PRD.md
