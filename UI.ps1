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

function Show-TemplateDialog {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "🐍 Select Python Template"
    $form.Size = New-Object System.Drawing.Size(750, 400)
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedDialog"
    $form.MaximizeBox = $false
    $form.MinimizeBox = $false
    $form.BackColor = [System.Drawing.Color]::FromArgb(248, 249, 250)
    Set-HighQualityRendering $form

    # Title Label
    $titleLabel = New-Object System.Windows.Forms.Label
    $titleLabel.Text = "Choose Your Python Template"
    $titleLabel.Location = New-Object System.Drawing.Point(30, 25)
    $titleLabel.Size = New-Object System.Drawing.Size(450, 35)
    $titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point)
    $titleLabel.ForeColor = [System.Drawing.Color]::FromArgb(32, 33, 36)
    $form.Controls.Add($titleLabel)

    # Template ListBox
    $templateListBox = New-Object System.Windows.Forms.ListBox
    $templateListBox.Location = New-Object System.Drawing.Point(30, 70)
    $templateListBox.Size = New-Object System.Drawing.Size(340, 120)
    $templateListBox.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point)
    $templateListBox.BackColor = [System.Drawing.Color]::White
    $form.Controls.Add($templateListBox)

    # Description Label
    $descLabel = New-Object System.Windows.Forms.Label
    $descLabel.Text = "Description:"
    $descLabel.Location = New-Object System.Drawing.Point(390, 70)
    $descLabel.Size = New-Object System.Drawing.Size(120, 25)
    $descLabel.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point)
    $descLabel.ForeColor = [System.Drawing.Color]::FromArgb(32, 33, 36)
    $form.Controls.Add($descLabel)

    # Description TextBox
    $descTextBox = New-Object System.Windows.Forms.TextBox
    $descTextBox.Location = New-Object System.Drawing.Point(390, 100)
    $descTextBox.Size = New-Object System.Drawing.Size(310, 70)
    $descTextBox.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point)
    $descTextBox.Multiline = $true
    $descTextBox.ReadOnly = $true
    $descTextBox.BackColor = [System.Drawing.Color]::FromArgb(248, 249, 250)
    $descTextBox.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
    $form.Controls.Add($descTextBox)

    # Custom Dependencies Section
    $customDepsLabel = New-Object System.Windows.Forms.Label
    $customDepsLabel.Text = "Additional Dependencies (optional):"
    $customDepsLabel.Location = New-Object System.Drawing.Point(30, 200)
    $customDepsLabel.Size = New-Object System.Drawing.Size(350, 25)
    $customDepsLabel.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point)
    $customDepsLabel.ForeColor = [System.Drawing.Color]::FromArgb(32, 33, 36)
    $form.Controls.Add($customDepsLabel)

    # Custom Dependencies TextBox
    $customDepsTextBox = New-Object System.Windows.Forms.TextBox
    $customDepsTextBox.Location = New-Object System.Drawing.Point(30, 230)
    $customDepsTextBox.Size = New-Object System.Drawing.Size(670, 60)
    $customDepsTextBox.Font = New-Object System.Drawing.Font("Consolas", 10, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point)
    $customDepsTextBox.Multiline = $true
    $customDepsTextBox.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
    $customDepsTextBox.BackColor = [System.Drawing.Color]::White
    $customDepsTextBox.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
    $customDepsTextBox.Text = "# Enter additional dependencies, one per line`n# Example:`n# requests>=2.28.0"
    $form.Controls.Add($customDepsTextBox)

    # Create Button
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(520, 310)
    $okButton.Size = New-Object System.Drawing.Size(85, 38)
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
    $cancelButton.Location = New-Object System.Drawing.Point(615, 310)
    $cancelButton.Size = New-Object System.Drawing.Size(85, 38)
    $cancelButton.Text = "Cancel"
    $cancelButton.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point)
    $cancelButton.BackColor = [System.Drawing.Color]::FromArgb(241, 243, 244)
    $cancelButton.ForeColor = [System.Drawing.Color]::FromArgb(60, 64, 67)
    $cancelButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $cancelButton.FlatAppearance.BorderSize = 1
    $cancelButton.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(218, 220, 224)
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.Controls.Add($cancelButton)

    # Template data
    $templates = Get-PythonTemplates
    $templateData = @()
    foreach ($key in $templates.Keys) {
        $template = $templates[$key]
        $templateListBox.Items.Add($template.description) | Out-Null
        $templateData += @{
            Key = $key
            Description = $template.description
            Dependencies = $template.dependencies
        }
    }

    # Event handler for template selection
    $templateListBox.Add_SelectedIndexChanged({
        if ($templateListBox.SelectedIndex -ge 0) {
            $selected = $templateData[$templateListBox.SelectedIndex]
            $descTextBox.Text = $selected.Description
        }
    })

    # Select first template by default
    if ($templateListBox.Items.Count -gt 0) {
        $templateListBox.SelectedIndex = 0
    }

    $result = $form.ShowDialog()
    
    if ($result -eq [System.Windows.Forms.DialogResult]::OK -and $templateListBox.SelectedIndex -ge 0) {
        $selectedTemplate = $templateData[$templateListBox.SelectedIndex]
        
        # Parse custom dependencies
        $customDeps = @()
        if (-not [string]::IsNullOrEmpty($customDepsTextBox.Text)) {
            $lines = $customDepsTextBox.Text -split "`n"
            foreach ($line in $lines) {
                $line = $line.Trim()
                if (-not [string]::IsNullOrEmpty($line) -and -not $line.StartsWith("#")) {
                    $customDeps += $line
                }
            }
        }

        return @{
            Key = $selectedTemplate.Key
            Description = $selectedTemplate.Description
            Dependencies = $selectedTemplate.Dependencies + $customDeps
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
