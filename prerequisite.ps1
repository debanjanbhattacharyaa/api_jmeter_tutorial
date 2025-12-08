# Requires PowerShell 5.0 or later (standard on Windows 10/11)

# --- CONFIGURATION ---
$PythonInstallerUrl = "https://www.python.org/ftp/python/3.11.8/python-3.11.8-amd64.exe"
$PythonFileName = "python_installer.exe"
$PythonInstallerArgs = "/quiet InstallAllUsers=1 PrependPath=1"
$GitInstallerUrl = "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe" # Stable Git for Windows link
$GitFileName = "git_installer.exe"
$GitInstallerArgs = "/SILENT /NORESTART /COMPONENTS='assoc,assocfiles,icons,cli'" # Silent install with minimal options

# --- HELPER FUNCTION TO CHECK COMMANDS ---
function Check-Command {
    param(
        [string]$CommandName,
        [string]$FriendlyName
    )
    Write-Host "Checking for $FriendlyName..."
    if (Get-Command $CommandName -ErrorAction SilentlyContinue) {
        Write-Host "✅ $FriendlyName found in PATH. Skipping download/install." -ForegroundColor Green
        return $true
    }
    Write-Host "❌ $FriendlyName not found." -ForegroundColor Yellow
    return $false
}

# -----------------------------------------------
# --- 1. CHECK AND INSTALL GIT ---
# -----------------------------------------------
if (-not (Check-Command "git" "Git")) {
    Write-Host "Downloading Git installer from $GitInstallerUrl..." -ForegroundColor Green
    try {
        Invoke-WebRequest -Uri $GitInstallerUrl -OutFile $GitFileName
        
        Write-Host "Starting Git installation. This may take a minute..." -ForegroundColor Yellow
        Start-Process -FilePath $GitFileName -ArgumentList $GitInstallerArgs -Wait
        Remove-Item $GitFileName
        
        Write-Host "Git installed and added to PATH." -ForegroundColor Green
        Write-Host "NOTE: You might need to restart your terminal for Git to be fully recognized." -ForegroundColor Yellow
    }
    catch {
        Write-Host "ERROR: Failed to download or install Git. Check URL or permissions." -ForegroundColor Red
        exit 1
    }
}

# -----------------------------------------------
# --- 2. CHECK AND INSTALL PYTHON & PIP ---
# -----------------------------------------------
if (-not (Check-Command "python" "Python 3")) {
    Write-Host "Downloading Python installer from $PythonInstallerUrl..." -ForegroundColor Green
    try {
        Invoke-WebRequest -Uri $PythonInstallerUrl -OutFile $PythonFileName
        
        Write-Host "Starting Python installation. This may take a minute..." -ForegroundColor Yellow
        Start-Process -FilePath $PythonFileName -ArgumentList $PythonInstallerArgs -Wait
        Remove-Item $PythonFileName
        
        Write-Host "Python 3 installed and added to PATH. Pip is included." -ForegroundColor Green
    }
    catch {
        Write-Host "ERROR: Failed to download or install Python. Check URL or permissions." -ForegroundColor Red
        exit 1
    }
} else {
    # If Python is found, ensure pip is updated (Good practice)
    Write-Host "Upgrading pip (best practice)..." -ForegroundColor Yellow
    python -m pip install --upgrade pip
}

# -----------------------------------------------
# --- 3. FINAL SUMMARY ---
# -----------------------------------------------
Write-Host "`n--- CORE TOOLS SETUP COMPLETE ---" -ForegroundColor Cyan
Write-Host "Git and Python/Pip are now available in your system PATH." -ForegroundColor Cyan
Write-Host "You can now proceed to clone your repository and set up your project environment." -ForegroundColor Cyan