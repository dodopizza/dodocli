#!/bin/bash
set -eu

# Get OS and platform
os=$(uname -s | tr '[:upper:]' '[:lower:]')
platform=$(uname -m | sed 's/x86_64/amd64/' | sed 's/aarch64/arm64/')

# Check if curl is installed
[ -z "$(command -v curl)" ] && echo 'curl must be installed' && exit 1

# Check for supported platform
case "$os/$platform" in
  darwin/amd64|darwin/arm64|linux/amd64|linux/arm64) ;;
  *)
    echo "Unsupported platform $os/$platform. Supports darwin/amd64, darwin/arm64, linux/amd64, linux/arm64."
    exit 1
    ;;
esac

# Create temporary directory
mkdir -p /tmp/first
curl -sL "https://github.com/dodopizza/dodocli/releases/latest/download/dodo_${os}_${platform}.zip" -o /tmp/first/dodo.zip
unzip /tmp/first/dodo.zip -d /tmp/first
chmod +x /tmp/first/dodo
/tmp/first/dodo --version

# Create directory for dodocli
mkdir -p "$HOME"/dodocli

# Move to home/dodocli
mv /tmp/first/dodo "$HOME"/dodocli

# Determine the shell and update the appropriate config file
if [[ "$SHELL" =~ "zsh" ]]; then
    CONFIG_FILE="$HOME/.zshrc"
elif [[ "$SHELL" =~ "bash" ]]; then
    CONFIG_FILE="$HOME/.bashrc"
else
    echo "Unsupported shell. Only zsh and bash are supported."
    exit 1
fi

# Add dodocli to PATH if not exists
if ! grep -q "dodocli" "$CONFIG_FILE"; then
    echo -e "\n# Add dodocli to PATH" >> "$CONFIG_FILE"
    echo "export PATH=\"$HOME/dodocli:\$PATH\"" >> "$CONFIG_FILE"
fi

echo "dodo CLI has been installed and the PATH has been updated."
echo "Please open a new terminal session or source your $CONFIG_FILE file to use dodo."

# Clean up
rm -rf /tmp/first

echo "Installation complete. Restart your terminal to start using dodo CLI"
