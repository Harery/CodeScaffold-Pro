# UI.ps1 - User Interface Functions for CodeScaffold Pro

function Set-HighQualityRendering {
    param($Control)
    if ($Control -is [System.Windows.Forms.Form]) {
        $Control.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Dpi
        $Control.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point)
    }
}

function Show-ProjectNameDialog {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "🐍 Python Project Generator"
    $form.Size = New-Object System.Drawing.Size(600, 350)
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedSingle"
    $form.MaximizeBox = $false
    $form.MinimizeBox = $false
    $form.BackColor = [System.Drawing.Color]::FromArgb(248, 249, 250)

    Set-HighQualityRendering $form

    # Title Label
    $titleLabel = New-Object System.Windows.Forms.Label
    $titleLabel.Text = "Create New Python Project"
    $titleLabel.Location = New-Object System.Drawing.Point(30, 25)
    $titleLabel.Size = New-Object System.Drawing.Size(540, 35)
    $titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point)
    $titleLabel.ForeColor = [System.Drawing.Color]::FromArgb(32, 33, 36)
    $form.Controls.Add($titleLabel)

    # Project Name Label
    $nameLabel = New-Object System.Windows.Forms.Label
    $nameLabel.Text = "Project Name:"
    $nameLabel.Location = New-Object System.Drawing.Point(30, 75)
    $nameLabel.Size = New-Object System.Drawing.Size(120, 25)
    $nameLabel.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point)
    $nameLabel.ForeColor = [System.Drawing.Color]::FromArgb(95, 99, 104)
    $form.Controls.Add($nameLabel)

    # Project Name TextBox
    $nameTextBox = New-Object System.Windows.Forms.TextBox
    $nameTextBox.Location = New-Object System.Drawing.Point(30, 105)
    $nameTextBox.Size = New-Object System.Drawing.Size(540, 32)
    $nameTextBox.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point)
    $nameTextBox.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
    $nameTextBox.BackColor = [System.Drawing.Color]::White
    $form.Controls.Add($nameTextBox)

    # Validation Label
    $validationLabel = New-Object System.Windows.Forms.Label
    $validationLabel.Location = New-Object System.Drawing.Point(30, 145)
    $validationLabel.Size = New-Object System.Drawing.Size(540, 50)
    $validationLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point)
    $validationLabel.Text = "Valid characters: lowercase letters a-z, numbers 0-9, hyphens, underscores. Length: 2-50 characters."
    $validationLabel.ForeColor = [System.Drawing.Color]::FromArgb(95, 99, 104)
    $form.Controls.Add($validationLabel)

    # Error Label
    $errorLabel = New-Object System.Windows.Forms.Label
    $errorLabel.Location = New-Object System.Drawing.Point(30, 200)
    $errorLabel.Size = New-Object System.Drawing.Size(540, 25)
    $errorLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point)
    $errorLabel.ForeColor = [System.Drawing.Color]::FromArgb(220, 53, 69)
    $errorLabel.Text = ""
    $form.Controls.Add($errorLabel)

    # Create Button
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(380, 260)
    $okButton.Size = New-Object System.Drawing.Size(100, 40)
    $okButton.Text = "Create"
    $okButton.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point)
    $okButton.BackColor = [System.Drawing.Color]::FromArgb(26, 115, 232)
    $okButton.ForeColor = [System.Drawing.Color]::White
    $okButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $okButton.FlatAppearance.BorderSize = 0
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.Controls.Add($okButton)

    # Cancel Button
    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Location = New-Object System.Drawing.Point(490, 260)
    $cancelButton.Size = New-Object System.Drawing.Size(100, 40)
    $cancelButton.Text = "Cancel"
    $cancelButton.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point)
    $cancelButton.BackColor = [System.Drawing.Color]::FromArgb(241, 243, 244)
    $cancelButton.ForeColor = [System.Drawing.Color]::FromArgb(60, 64, 67)
    $cancelButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $cancelButton.FlatAppearance.BorderSize = 1
    $cancelButton.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(218, 220, 224)
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.Controls.Add($cancelButton)

    # Validation function
    $validateName = {
        $name = $nameTextBox.Text
        if ([string]::IsNullOrWhiteSpace($name)) {
            $errorLabel.Text = "Project name cannot be empty"
            $okButton.Enabled = $false
            return
        }

        if ($name -notmatch '^[a-z0-9_-]+$') {
            $errorLabel.Text = "Project name must be all lowercase letters, numbers, hyphens, or underscores (no uppercase allowed)"
            $okButton.Enabled = $false
            return
        }

        if ($name.Length -lt 2 -or $name.Length -gt 50) {
            $errorLabel.Text = "Name must be between 2 and 50 characters"
            $okButton.Enabled = $false
            return
        }

        $errorLabel.Text = ""
        $okButton.Enabled = $true
    }

    $nameTextBox.Add_TextChanged($validateName)
    $form.Add_Load({ $nameTextBox.Focus() })

    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return $nameTextBox.Text
    }

    return $null
}

function Show-OSTemplateOptionsDialog {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "🖥️ Select OS Features for Dockerfile"
    $form.Size = New-Object System.Drawing.Size(500, 420)
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedDialog"
    $form.MaximizeBox = $false
    $form.MinimizeBox = $false
    $form.BackColor = [System.Drawing.Color]::FromArgb(248, 249, 250)
    Set-HighQualityRendering $form

    $titleLabel = New-Object System.Windows.Forms.Label
    $titleLabel.Text = "Choose OS Features to Include in Dockerfile:"
    $titleLabel.Location = New-Object System.Drawing.Point(30, 25)
    $titleLabel.Size = New-Object System.Drawing.Size(420, 35)
    $titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
    $form.Controls.Add($titleLabel)

    $checkboxes = @{}
    $features = @(
        @{ Name = 'Apt Utils';        Key = 'AptUtils';    Default = $true;   Desc = 'Install apt-utils (recommended for apt scripts)'; },
        @{ Name = 'Locales';          Key = 'Locales';    Default = $true;   Desc = 'Install and configure locales (UTF-8, Arabic)'; },
        @{ Name = 'SSH Server';       Key = 'SSH';        Default = $false;  Desc = 'Install and configure OpenSSH server'; },
        @{ Name = 'Python';           Key = 'Python';     Default = $false;  Desc = 'Install Python 3, pip, and dev tools'; },
        @{ Name = 'Node.js & npm';    Key = 'Node';       Default = $false;  Desc = 'Install Node.js (LTS) and npm'; },
        @{ Name = 'UFW Firewall';     Key = 'UFW';        Default = $false;  Desc = 'Install and configure UFW firewall'; },
        @{ Name = 'Fail2Ban';         Key = 'Fail2Ban';   Default = $false;  Desc = 'Install Fail2Ban for SSH protection'; }
    )
    $y = 70
    foreach ($feature in $features) {
        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Text = $feature.Name + "  -  " + $feature.Desc
        $cb.Location = New-Object System.Drawing.Point(40, $y)
        $cb.Size = New-Object System.Drawing.Size(400, 25)
        $cb.Checked = $feature.Default
        $form.Controls.Add($cb)
        $checkboxes[$feature.Key] = $cb
        $y += 35
    }

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(270, 340)
    $okButton.Size = New-Object System.Drawing.Size(90, 38)
    $okButton.Text = "Create"
    $okButton.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
    $okButton.BackColor = [System.Drawing.Color]::FromArgb(26, 115, 232)
    $okButton.ForeColor = [System.Drawing.Color]::White
    $okButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $okButton.FlatAppearance.BorderSize = 0
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.Controls.Add($okButton)

    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Location = New-Object System.Drawing.Point(370, 340)
    $cancelButton.Size = New-Object System.Drawing.Size(90, 38)
    $cancelButton.Text = "Cancel"
    $cancelButton.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Regular)
    $cancelButton.BackColor = [System.Drawing.Color]::FromArgb(241, 243, 244)
    $cancelButton.ForeColor = [System.Drawing.Color]::FromArgb(60, 64, 67)
    $cancelButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $cancelButton.FlatAppearance.BorderSize = 1
    $cancelButton.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(218, 220, 224)
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.Controls.Add($cancelButton)

    $result = $form.ShowDialog()
    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return @{
            InstallAptUtils = $checkboxes['AptUtils'].Checked
            InstallLocales = $checkboxes['Locales'].Checked
            InstallSSH = $checkboxes['SSH'].Checked
            InstallPython = $checkboxes['Python'].Checked
            InstallNode = $checkboxes['Node'].Checked
            InstallUFW = $checkboxes['UFW'].Checked
            InstallFail2Ban = $checkboxes['Fail2Ban'].Checked
        }
    }
    return $null
}

function Select-Folder {
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowser.Description = "Select folder for your Python project"
    $folderBrowser.ShowNewFolderButton = $true
    
    if ($folderBrowser.ShowDialog() -eq "OK") {
        return $folderBrowser.SelectedPath
    }
    return $null
}
