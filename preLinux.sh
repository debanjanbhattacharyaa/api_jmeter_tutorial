#!/bin/bash

# --- CONFIGURATION ---
REPO_URL="https://github.com/YOUR-USERNAME/flask-jwt-tutorial-api.git" # <-- !!! UPDATE THIS URL !!!
PYTHON_PACKAGES="Flask Flask-JWT-Extended"

# --- HELPER FUNCTION TO CHECK COMMANDS ---
check_command() {
    local command_name=$1
    local friendly_name=$2
    echo "Checking for $friendly_name..."
    if command -v "$command_name" &> /dev/null; then
        echo "✅ $friendly_name found in PATH. Skipping installation."
        return 0 # Command exists
    else
        echo "❌ $friendly_name not found."
        return 1 # Command does not exist
    fi
}

# --- DETERMINE PACKAGE MANAGER ---
# Find the appropriate package manager for the distribution (apt, yum, dnf)
if command -v apt-get &> /dev/null; then
    PKG_MANAGER="apt-get"
    INSTALL_CMD="sudo $PKG_MANAGER update && sudo $PKG_MANAGER install -y"
    PYTHON_PKG="python3 python3-pip git"
elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
    INSTALL_CMD="sudo $PKG_MANAGER install -y"
    PYTHON_PKG="python3 python3-pip git"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
    INSTALL_CMD="sudo $PKG_MANAGER install -y"
    PYTHON_PKG="python3 python3-pip git"
else
    echo "ERROR: Unsupported package manager. Please install Git and Python 3 manually."
    exit 1
fi

# -----------------------------------------------
# --- 1. CHECK AND INSTALL CORE TOOLS (GIT & PYTHON) ---
# -----------------------------------------------
echo "--- Installing Core Tools ---"
if ! check_command "git" "Git" || ! check_command "python3" "Python 3"; then
    echo "Installing missing packages using $PKG_MANAGER..."
    $INSTALL_CMD $PYTHON_PKG
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to install packages. Check permissions (sudo) or network connection."
        exit 1
    fi
fi

# -----------------------------------------------
# --- 2. INSTALL PYTHON DEPENDENCIES GLOBALLY ---
# -----------------------------------------------
echo " "
echo "Installing project dependencies ($PYTHON_PACKAGES) globally..."
# Check for pip3 and install dependencies
if command -v pip3 &> /dev/null; then
    # Use sudo if we are installing system-wide (common for Linux)
    sudo pip3 install --upgrade pip
    sudo pip3 install $PYTHON_PACKAGES
    if [ $? -ne 0 ]; then
        echo "WARNING: Failed to install dependencies globally. Trying without sudo (user installation)."
        # Fallback to user installation
        pip3 install --user $PYTHON_PACKAGES
    fi
    echo "Python dependencies installed successfully."
else
    echo "WARNING: pip3 command not found. Please ensure python3-pip is installed."
fi

# -----------------------------------------------
# --- 3. FINAL SUMMARY ---
# -----------------------------------------------
echo " "
echo "--- CORE TOOLS SETUP COMPLETE ---"
echo "Git, Python, and required libraries are now installed."
echo "NEXT STEPS:"
echo "1. Clone the repository: git clone $REPO_URL"
echo "2. Navigate: cd $(basename $REPO_URL .git)"
echo "3. Setup Venv: python3 -m venv venv && source venv/bin/activate"