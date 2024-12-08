```markdown
# Instructions for Setting up the Project

This guide shows how to create and organize a Git repository so that other users (or AIs) can easily pull it and install a Bash utility script called `merge-files` on their machine. The script merges all non-ignored files from a Git repository into a single file, respecting both `.gitignore` and a custom `.mergeignore` file.

## Project Structure

Your repository should look like this:

```
your-repo/
├─ install.sh
├─ merge-files
├─ .mergeignore
└─ README.md
```

- **merge-files**: The Bash script to perform the merging operation.
- **.mergeignore**: A file containing additional patterns of files to ignore (e.g., `*.db`, `*.lock`).
- **install.sh**: A shell script that, when run, installs the `merge-files` utility into a user’s `~/bin` directory or another specified path.
- **README.md**: Documentation for users (this file).

## merge-files Script

Below is the `merge-files` script. It:

1. Expects two arguments: `<source git directory>` and `<destination file>`.
2. Changes to the source directory.
3. Uses `git ls-files` to list non-ignored files (tracked and untracked).
4. Also respects `.mergeignore` if present, filtering out files listed there.
5. Concatenates these files into the destination file, prefixing each file’s content with a header line.

```bash
#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 2 ]; then
    echo "Usage: $0 <source git directory> <destination file>"
    exit 1
fi

src_dir="$1"
dest_file="$2"

cd "$src_dir"

if [ -f .mergeignore ]; then
    files=$(git ls-files --cached --others --exclude-standard --exclude-from=.mergeignore)
else
    files=$(git ls-files --cached --others --exclude-standard)
fi

> "$dest_file"

for f in $files; do
    if [ -f "$f" ]; then
        echo "### $f ###" >> "$dest_file"
        cat "$f" >> "$dest_file"
        echo >> "$dest_file"
    fi
done

echo "All non-ignored files from '$src_dir' have been merged into '$dest_file'."
```

## .mergeignore Example

This file should list additional patterns to exclude from the merging process. For example:

```txt
*.db
*.lock
```

This ignores all `.db` and `.lock` files.

## install.sh Script

This script installs `merge-files` into a directory that is in the user’s PATH (typically `~/bin`). If `~/bin` does not exist, it creates it and ensures it’s on the PATH for future sessions. Running this script should require no additional parameters. Users can simply run `./install.sh` after cloning the repo.

```bash
#!/usr/bin/env bash
set -euo pipefail

# Ensure ~/bin exists
mkdir -p "$HOME/bin"

# Copy merge-files to ~/bin
cp merge-files "$HOME/bin/merge-files"
chmod +x "$HOME/bin/merge-files"

# Add ~/bin to PATH if it's not already there
if ! echo "$PATH" | grep -q "$HOME/bin"; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
    echo "Added \$HOME/bin to PATH. Please run 'source ~/.bashrc' or open a new terminal."
fi

echo "merge-files installed successfully. You can now run 'merge-files' from any directory."
```

## How to Use the Repository

1. **Clone the Repository**:  
   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo
   ```

2. **Run the Installation Script**:  
   ```bash
   ./install.sh
   ```
   
   Follow any instructions printed by `install.sh`. If you had to add `~/bin` to your PATH, either open a new terminal or run:  
   ```bash
   source ~/.bashrc
   ```

3. **Use `merge-files`**:  
   Navigate to a Git repository (or a subdirectory) and run:  
   ```bash
   merge-files . output.txt
   ```
   
   This command takes the current directory as the source and merges all non-ignored files into `output.txt`. Any `.mergeignore` file in that directory will also be respected.

## Benefits of This Setup

- **Easy Installation**: Just pull the repo and run `install.sh`.
- **Reusable**: The user can install `merge-files` once, and then use it in any other repository or directory.
- **Custom Ignoring**: By using `.mergeignore`, users can specify additional files or patterns to exclude.
- **Portable**: Since it’s a simple Bash script with no external dependencies besides `git`, it works on any machine with a Bash-compatible shell and Git installed.

----

This setup is designed to be straightforward and universal. Another AI or any user can easily follow these steps, clone the repo, and get started with the `merge-files` script in minutes.
```