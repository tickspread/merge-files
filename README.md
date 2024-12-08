# merge-files

A Bash utility script that merges files from a Git repository into a single file, respecting both `.gitignore` and `.mergeignore`. It can now optionally merge only a specified set of files listed in a separate file.

## Installation

Quick install (one-liner):
```bash
cd ~ && git clone https://github.com/tickspread/merge-files.git && cd merge-files && ./install.sh && source ~/.bashrc
```

Or step by step:

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
merge-files --source <source git directory> --destination <destination file> [--paths-file <file_with_paths>]
```

Short options are also available:
```bash
merge-files -s <source git directory> -d <destination file> [-p <file_with_paths>]
```

**Examples:**
- Merge all non-ignored files from the current directory into `output.txt`:
  ```bash
  merge-files -s . -d output.txt
  ```

- Merge only the files listed in `files_to_merge.txt` (which must also not be ignored) into `filtered_output.txt`:
  ```bash
  merge-files --source . --destination filtered_output.txt --paths-file files_to_merge.txt
  ```

## Features

- Respects `.gitignore` patterns
- Supports additional ignore patterns via `.mergeignore`
- Can optionally merge only files listed in a specified file
- Prefixes each file's content with a header line
- Works with both tracked and untracked files
- Simple installation process

## Configuration

Create a `.mergeignore` file in your repository to specify additional patterns to exclude from the merging process. For example:

```
*.db
*.lock
```

This will ignore all `.db` and `.lock` files. You can also create a separate file (passed via `--paths-file`) containing a whitelist of files to merge:

```
some_file.txt
src/main.c
docs/readme.md
```

This will ensure that only these listed files are considered from the repository (if they are not ignored). 