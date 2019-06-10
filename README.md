# Windows Powershell utility for zipping multiple folders.
Usage is: `7Zip-Multiple [[-Src ]<Src>] [[-Dest ]<Dest>] [-ZipInPlace] [-Use7Zip]`

#### Input parameters:
- `Src`
  - `Src` is the folder whose subfolders will be zipped.
  - If `Src` is left blank, the current directory will be used.
  - If `Src` is invalid, the script will terminate.
  - Absolute and relative paths are accepted.

- `Dest`
  - `Dest` is the folder where the zipped files will be stored.
  - If `Dest` is left blank, a folder called `_zipped` will be created in `Src` and the zipped files will be stored there.
  - Absolute and relative paths are accepted.
  - **NOTE:** If `Dest` is located inside `Src`, it will not be zipped.

- `ZipInPlace`
  - The `ZipInPlace` switch tells the utility to place the zipped files in the `Src` directory. It overrides the `Dest` parameter if present.

- `Use7Zip`
  - Uses 7-zip to compress files instead of default Windows compression.
  - **NOTE:** This utility expects `7z.exe` to be installed at `C:\Program Files\7-zip\`

#### Examples:
- `7Zip-Multiple`
  - Compresses the contents of each folder located in the current directory and places the zip files into a folder called `_zipped` in the current directory.

- `7Zip-Multiple dir1 -ZipInPlace`
  - Compresses the contents of each folder located in a folder called `dir1` inside the current directory and places the zip files into `dir1`.

- `7Zip-Multiple -Dest C:\dir2 -Use7Zip`
  - Compresses the contents of each folder located in the current directory and places the zip files into `C:\dir2`. Use 7-zip for compression.
---
Created by Steve Dinkle 2019-06-02

Last updated 2019-06-10
