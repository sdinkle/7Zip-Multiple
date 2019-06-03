# Powershell utility for zipping multiple folders using 7-zip.
Useful for creating multiple SCORM PIFs at once.

Usage is:
7Zip-Multiple [[-Src ]<Src>] [[-Dest ]<Dest>] [-ZipInPlace]

#### Input parameters:
- Src
  - Src is the folder whose subfolders will be zipped.
  - If Src is left blank, the current directory will be used.
  - If Src is invalid, the script will terminate.
  - Absolute and relative paths are accepted.

- Dest
  - Dest is the folder where the zipped files will be stored.
  - If Dest is left blank, a folder called _zipped will be created in Src and the zipped files will be stored there.
  - Absolute and relative paths are accepted.
  - NOTE: If Dest is located inside Src, it will not be zipped.

- ZipInPlace
  - The ZipInPlace switch tells the utility to place the zipped files in the Src directory. It overrides the Dest parameter if present.

#### Examples:
- 7Zip-Multiple
  - Compresses the contents of each folder located in the current directory and places the zip files into a folder called _zipped in the current directory.

- 7Zip-Multiple dir1 -ZipInPlace
  - Compresses the contents of each folder located in a folder called dir1 inside the current directory and places the zip files into dir1.

- 7Zip-Multiple -Dest C:\dir2
  - Compresses the contents of each folder located in the current directory and places the zip files into C:\dir2.
#
Created by Steve Dinkle 2019-06-02
