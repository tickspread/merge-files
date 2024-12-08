# merge-files

A Bash utility script that merges all non-ignored files from a Git repository into a single file, respecting both `.gitignore` and a custom `.mergeignore` file.

## Installation

1. Clone this repository:
   ```bash
   git clone git@github.com:tickspread/merge-files.git
   cd merge-files
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

   If prompted about PATH updates, either open a new terminal or run:
   ```bash
   source ~/.bashrc
   ```

## Usage

Navigate to any Git repository (or subdirectory) and run:
```bash
merge-files <source git directory> <destination file>
```

Example:
```bash
merge-files . output.txt
```

This will merge all non-ignored files from the current directory into `output.txt`.

## Features

- Respects `.gitignore` patterns
- Supports additional ignore patterns via `.mergeignore`
- Prefixes each file's content with a header line
- Works with both tracked and untracked files
- Simple installation process

## Configuration

You can create a `.mergeignore` file in your repository to specify additional patterns to exclude from the merging process. For example:

```
*.db
*.lock
```

This will ignore all `.db` and `.lock` files during the merge process. 