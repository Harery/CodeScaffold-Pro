# Templates.ps1 - Template definitions for CodeScaffold Pro

function Get-OSTemplates {
    param(
        [bool]$InstallAptUtils = $true,
        [bool]$InstallLocales = $true,
        [bool]$InstallSSH = $false,
        [bool]$InstallPython = $false,
        [bool]$InstallNode = $false,
        [bool]$InstallUFW = $false,
        [bool]$InstallFail2Ban = $false
    )
    $lines = @()
    $lines += "FROM ubuntu:latest"
    $lines += ""
    $lines += "# Set noninteractive mode for apt"
    $lines += "ENV DEBIAN_FRONTEND=noninteractive"
    $lines += ""
    $runCmd = @()
    $runCmd += "apt update"
    $runCmd += "apt upgrade -y"
    $runCmd += "apt dist-upgrade -y"
    if ($InstallAptUtils) {
        $runCmd += "apt install -y apt-utils"
    }
    $runCmd += "apt clean"
    $runCmd += "rm -rf /var/lib/apt/lists/*"
    $runCmd += "apt update"
    if ($InstallLocales) {
        $runCmd += "apt install -y locales curl"
        $runCmd += "locale-gen en_US.UTF-8 ar_SA.UTF-8"
        $runCmd += "update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8"
    }
    $runCmd += "mkdir -p /harery_dev"
    # Use a single backslash for Dockerfile line continuation
    $lines += "RUN " + ($runCmd -join " && `\
    ")
    $lines += ""
    if ($InstallLocales) {
        # Set locale environment variables globally
        $lines += "ENV LANG=en_US.UTF-8"
        $lines += "ENV LANGUAGE=en_US:en"
        $lines += "ENV LC_ALL=en_US.UTF-8"
        $lines += ""
    }
    if ($InstallSSH) {
        # Configure SSH (set a default password for root or create user if required)
        $lines += @"
RUN apt install -y openssh-server && \
    mkdir /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
"@
        $lines += ""
    }
    if ($InstallPython) {
        # Install latest pip and Python packages in a virtual environment (PEP 668 compliant)
        $lines += @"
RUN apt install -y python3 python3-pip python3-venv && \
    python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install setuptools pre-commit mypy rich pipenv virtualenv loguru python-dotenv black && \
    ln -s /opt/venv/bin/pip /usr/local/bin/pip && \
    ln -s /opt/venv/bin/python /usr/local/bin/python
"@
        $lines += ""
    }
    if ($InstallNode) {
        # Install Node.js latest LTS via NodeSource for always up-to-date node
        $lines += @"
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt install -y nodejs
"@
        $lines += ""
    }
    if ($InstallUFW) {
        # Configure firewall for SSH, HTTP, and HTTPS (enable at runtime, not build time)
        $lines += @"
RUN apt install -y ufw && \
    ufw allow 22 && \
    ufw allow 80 && \
    ufw allow 443
"@
        $lines += ""
    }
    if ($InstallFail2Ban) {
        # Install Fail2Ban
        $lines += "RUN apt install -y fail2ban"
        $lines += ""
    }
    $lines += "WORKDIR /app"
    $lines += ""
    $lines += "# Copy application code"
    $lines += "COPY . ."
    $lines += ""
    # Compose startup command
    if ($InstallSSH -or $InstallFail2Ban -or $InstallUFW) {
        $lines += "# Start enabled services on container startup"
        $lines += @'
CMD ["bash", "-c", "\
service ssh start && \
service fail2ban start && \
ufw --force enable && \
echo '\\n========== Container Service Summary ==========' && \
echo 'SSH: '$(service ssh status | grep -o 'Active:.*') && \
echo 'UFW: '$(ufw status | head -n 1) && \
echo 'Fail2Ban: '$(service fail2ban status | grep -o 'Active:.*') && \
python3 --version 2>/dev/null && \
pip --version 2>/dev/null && \
node --version 2>/dev/null && \
npm --version 2>/dev/null && \
exec bash \"]
'@
    } else {
        $lines += 'CMD ["bash"]'
    }
    return $lines -join "`n"
}
