# Xlsx2Exif

Xlsx2Exif is a Ruby application for updating EXIF data in photos based on information stored in an Excel spreadsheet.
Gives you status feedback, and an report on unmatched data or complet success otherwise.
Works only with .xlsx

## Installation

### Clone the Xlsx2Exif repository:

git clone https://github.com/yourusername/Xlsx2Exif.git
cd Xlsx2Exif

### Dependencies

1. Make sure you have Ruby 1.9 or higher installed on your system.
2. run
  ```bash
    bundle
  ```
  to install the gems used in the app, [roo](https://rubygems.org/gems/roo) and [mini_exiftool](https://rubygems.org/gems/mini_exiftool)
3. Please ensure you have installed exiftool at least version 7.65
   and it's found in your PATH (Try "exiftool -ver" on your commandline).

## Usage
```bash
bin/app.rb path/to/table.xlsx path/to/photos_folder
```
path/to/table.xlsx: Path to the Excel spreadsheet containing EXIF data.
path/to/photos_folder: Path to the folder containing photos to be processed.
