# Add paths-file support and modernize CLI arguments

## Changes
This PR introduces two major improvements to the merge-files utility:

1. **Paths File Support**: Added the ability to specify a whitelist of files to merge via a paths file
   - New `--paths-file` (or `-p`) argument to specify which files to include
   - Only merges files that are both in the paths file AND not ignored
   - Gracefully handles non-existent paths files with clear error messages

2. **Modernized CLI Interface**: Updated command-line arguments to follow standard conventions
   - Long options: `--source`, `--destination`, `--paths-file`
   - Short options: `-s`, `-d`, `-p`
   - Added help option (`-h`, `--help`) with improved usage documentation
   - Maintained backward compatibility with existing functionality

## Example Usage
```bash
# Merge all non-ignored files (existing behavior)
merge-files -s . -d output.txt

# Merge only specific files listed in paths.txt
merge-files --source . --destination output.txt --paths-file paths.txt
```

## Testing
- Tested with various combinations of:
  - Empty/non-empty paths files
  - Ignored and non-ignored files
  - Both long and short argument forms
  - Files with special characters in names

## Documentation
- Updated README.md with new functionality and examples
- Added detailed configuration section about paths file format
- Improved command-line help output 