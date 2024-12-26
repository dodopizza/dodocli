#!/bin/bash

# Get OS and platform
os=$(uname -s | tr '[:upper:]' '[:lower:]')
platform=$(uname -m)

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

# setup config
cat <<EOF >> "$HOME"/dodocli/.dodocli
[default]
tenantId = "585ca83d-87b8-4ca9-8a30-98085370c548"
clientId = "8f27073c-3b4e-4700-a67c-a761778ef581"
subscriptionId = "f5954335-be33-4b17-9f4f-e12d152f5ebe"
EOF

echo "Installation complete. Restart your terminal to start using dodo CLI"