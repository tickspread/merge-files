#!/usr/bin/env bash
set -euo pipefail

# Ensure ~/bin exists
mkdir -p "$HOME/bin"

# Copy merge-files to ~/bin
cp merge-files "$HOME/bin/merge-files"
chmod +x "$HOME/bin/merge-files"

# Update PATH for current session
export PATH="$HOME/bin:$PATH"

# Add ~/bin to PATH in shell config files if not already there
update_rc_file() {
    local rc_file="$1"
    if [ -f "$rc_file" ] && ! grep -q 'export PATH="$HOME/bin:$PATH"' "$rc_file"; then
        echo 'export PATH="$HOME/bin:$PATH"' >> "$rc_file"
    fi
}

# Update common shell config files
update_rc_file "$HOME/.bashrc"
update_rc_file "$HOME/.zshrc"
update_rc_file "$HOME/.profile"

echo "merge-files installed successfully and PATH has been updated."
echo "The utility is ready to use in this terminal and will be available in new terminals." 