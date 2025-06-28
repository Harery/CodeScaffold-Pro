# Main.ps1 - Main execution logic for CodeScaffold Pro

function Test-VSCode {
    try {
        $null = Get-Command "code" -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

function Test-Git {
    try {
        $null = Get-Command "git" -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

function Test-Docker {
    try {
        $null = Get-Command "docker" -ErrorAction Stop
        $dockerVersion = docker --version 2>$null
        return $null -ne $dockerVersion
    } catch {
        return $false
    }
}

function Test-GitHubCLI {
    try {
        $null = Get-Command "gh" -ErrorAction Stop

        # Check Git global configuration
        $gitUserName = git config --global user.name
        $gitUserEmail = git config --global user.email

        if (-not $gitUserName -or -not $gitUserEmail) {
            Write-Warning "Git global configuration is incomplete. Missing user.name or user.email."
            Write-Warning "Example commands to configure Git:"
            Write-Warning "  git config --global user.name ""Your Name"""
            Write-Warning "  git config --global user.email ""you@example.com"""
        }

        return $true
    } catch {
        return $false
    }
}

function Write-ColorOutput {
    param([string]$Message, [string]$Color = "White")
    if (-not $script:Quiet) {
        Write-Host $Message -ForegroundColor $Color
    }
}

function Write-Success { param([string]$Message) Write-ColorOutput "✅ $Message" "Green" }
function Write-Warning { param([string]$Message) Write-ColorOutput "⚠️  $Message" "Yellow" }
function Write-Error { param([string]$Message) Write-ColorOutput "❌ $Message" "Red" }
function Write-Info { param([string]$Message) Write-ColorOutput "ℹ️  $Message" "Cyan" }

function Invoke-MainLogic {
    param(
        [bool]$SkipValidation,
        [bool]$Quiet
    )
    
    # Set script-level variable for quiet mode
    $script:Quiet = $Quiet

    Write-Info "🐍 CodeScaffold Pro"
    Write-Info "=============================================="
    
    # Tool validation
    if (-not $SkipValidation) {
        Write-Info "Validating required tools..."
        $tools = @{
            "VSCode" = Test-VSCode
            "Git" = Test-Git
            "Docker" = Test-Docker
            "GitHub CLI" = Test-GitHubCLI
        }
        $allToolsOk = $true
        foreach ($tool in $tools.GetEnumerator()) {
            if ($tool.Value) {
                Write-Success "$($tool.Key) is available"
            } else {
                Write-Warning "$($tool.Key) is not available. Please install or repair $($tool.Key) and re-run the script."
                $allToolsOk = $false
            }
        }
        if (-not $allToolsOk) {
            Write-Error "Required tools are missing. Exiting."
            return
        }
        if (-not $tools["Git"]) {
            Write-Error "Git is required for this script. Please install Git and try again."
            return
        }
    }
    
    #region Folder selection
    Write-Info "Select project folder..."
    $projectFolder = Select-Folder
    if (-not $projectFolder) {
        Write-Error "No folder selected. Exiting."
        return
    }
    Write-Success "Selected folder: $projectFolder"
    #endregion
    
    #region Project name input
    Write-Info "Enter project details..."
    $projectName = Show-ProjectNameDialog
    if (-not $projectName) {
        Write-Info "Operation cancelled."
        return
    }
    Write-Success "Project name: $projectName"
    $fullProjectPath = Join-Path $projectFolder $projectName
    if (Test-Path $fullProjectPath) {
        $overwrite = [System.Windows.Forms.MessageBox]::Show(
            "Project folder already exists. Do you want to overwrite it?", 
            "Folder Exists", 
            [System.Windows.Forms.MessageBoxButtons]::YesNo,
            [System.Windows.Forms.MessageBoxIcon]::Question
        )
        if ($overwrite -eq [System.Windows.Forms.DialogResult]::No) {
            Write-Info "Operation cancelled."
            return
        }
    }
    #endregion
    
    #region Template selection
    Write-Info "Select project template..."
    $templateInfo = Show-TemplateDialog
    if (-not $templateInfo) {
        Write-Info "Operation cancelled."
        return
    }
    Write-Success "Selected template: $($templateInfo.Key)"
    if ($templateInfo.Dependencies.Count -gt 0) {
        Write-Info "Dependencies: $($templateInfo.Dependencies -join ', ')"
    }
    #endregion

    #region Dynamic port assignment
    # Find an available local port (starting from 8000) to avoid Docker conflicts
    $basePort = 8000
    $hostPort = $basePort
    $usedPorts = docker ps --format "{{.Ports}}" | Select-String -Pattern '(\d+)->' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique
    while ($usedPorts -contains $hostPort.ToString()) {
        $hostPort++
    }
    if ($hostPort -ne $basePort) {
        Write-Warning "Port $basePort is in use. Using available port $hostPort instead."
    } else {
        Write-Info "Using default port $hostPort."
    }
    #endregion

    #region Project structure generation
    Write-Info "Creating project structure..."
    if (Test-Path $fullProjectPath) {
        Remove-Item $fullProjectPath -Recurse -Force
    }
    New-Item -ItemType Directory -Path $fullProjectPath -Force | Out-Null
    #endregion

    #region File generation
    # Internal config file for storing project metadata
    $files = @{
        "main.py" = New-MainPy $templateInfo.Key
        "Dockerfile" = New-Dockerfile $templateInfo.Key
        "requirements.txt" = New-RequirementsTxt $templateInfo.Dependencies
        "README.md" = New-ReadmeMd $projectName $templateInfo.Key
        ".gitignore" = New-GitIgnore
        ".project.config" = New-ProjectConfig $projectName $templateInfo.Key
        "docker-compose.yml" = New-DockerCompose $projectName "python main.py" $hostPort
    }
    
    foreach ($file in $files.GetEnumerator()) {
        $filePath = Join-Path $fullProjectPath $file.Key
        $file.Value | Out-File -FilePath $filePath -Encoding UTF8
        Write-Success "Created $($file.Key)"
    }
    #endregion

    #region DevContainer setup
    $devcontainerDir = Join-Path $fullProjectPath ".devcontainer"
    New-Item -ItemType Directory -Path $devcontainerDir -Force | Out-Null
    $devcontainerFile = Join-Path $devcontainerDir "devcontainer.json"
    New-DevContainer | Out-File -FilePath $devcontainerFile -Encoding UTF8
    Write-Success "Created .devcontainer/devcontainer.json"
    #endregion

    #region Git initialization
    if (Test-Git) {
        Write-Info "Initializing Git repository..."
        Set-Location $fullProjectPath
        git init | Out-Null
        git add . | Out-Null
        git commit -m "Initial commit: $($templateInfo.Key) project setup" | Out-Null
        Write-Success "Git repository initialized"
    }
    #endregion

    #region Docker build and environment setup
    if (Test-Docker) {
        Write-Info "Building and starting Docker container..."
        try {
            # Build Docker image
            $buildResult = docker build -t $projectName $fullProjectPath 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Success "Docker image '$projectName' built successfully."
                
                # Start container using docker-compose
                Push-Location $fullProjectPath
                $composeResult = docker-compose up -d 2>&1
                Pop-Location
                if ($LASTEXITCODE -eq 0) {
                    Write-Success "Docker container started successfully."
                }
            }
        } catch {
            Write-Warning "Docker operations failed: $_"
        }
    }
    #endregion
    
    # Summary
    Write-Host "`n🎉 Project '$projectName' created successfully!" -ForegroundColor Green
    Write-Host "📁 Location: $fullProjectPath" -ForegroundColor Cyan
    Write-Host "🚀 Ready for development!" -ForegroundColor Green
}
