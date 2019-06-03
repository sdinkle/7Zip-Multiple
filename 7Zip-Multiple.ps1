###############################################################################
# Windows Powershell utility for zipping multiple folders using 7-zip.
# NOTE: This utility expects 7z.exe to be installed at C:\Program Files\7-zip\
#
# Usage is:
# 7Zip-Multiple [[-Src ]<Src>] [[-Dest ]<Dest>] [-ZipInPlace]
# 
# Input parameters:
# - Src
#   Src is the folder whose subfolders will be zipped.
#   If Src is left blank, the current directory will be used.
#   If Src is invalid, the script will terminate.
#   Absolute and relative paths are accepted.
#
# - Dest
#   Dest is the folder where the zipped files will be stored.
#   If Dest is left blank, a folder called _zipped will be created in Src
#   and the zipped files will be stored there.
#   Absolute and relative paths are accepted.
#   NOTE: If Dest is located inside Src, it will not be zipped.
#
# - ZipInPlace
#   The ZipInPlace switch tells the utility to place the zipped files in 
#   the Src directory. It overrides the Dest parameter if present.
#
# Examples:
# - 7Zip-Multiple
#   Compresses the contents of each folder located in the current
#   directory and places the zip files into a folder called _zipped in the
#   current directory.
#
# - 7Zip-Multiple dir1 -ZipInPlace
#   Compresses the contents of each folder located in a folder called
#   dir1 inside the current directory and places the zip files into dir1.
#
# - 7Zip-Multiple -Dest C:\dir2
#   Compresses the contents of each folder located in the current
#   directory and places the zip files into C:\dir2.
#
# Created by Steve Dinkle 2019-06-02
###############################################################################

# Establish input parameters.
param
(
    [string]$Src = ".",
    [string]$Dest = ($Src+"\_zipped"),
    [switch]$ZipInPlace
)

# Set the destination to the source folder if the -ZipInPlace switch is present.
if ($ZipInPlace) {
    $Dest = $Src
}

# Test to see if 7-zip is installed at the expected location.
$7z = "C:\Program Files\7-zip\7z.exe"
if ((Test-Path "C:\Program Files\7-Zip\7z.exe") -ne "True") {
    Write-Output "Please verify that 7z.exe exists at C:\Program Files\7-zip\"
    exit
}

# Resolve the source path.
try {
    $SrcPath = (Get-Item $Src -ErrorAction Stop).FullName
} catch {
    Write-Output ("The specified source folder "+$Src+" does not exist.")
    exit
}

# Create the destination folder if it's not there.
# Redirect any output to $null to silence output.
if ((Test-Path $Dest) -ne "True") {
    New-Item -ItemType "directory" $Dest > $null
}

# Resolve the destination folder name and path.
$DestPath = (Get-Item $Dest).FullName
$DestName = (Get-Item $DestPath).Name

# Get a list of subfolders in the source path that will be compressed.
# Don't include the output folder if not zipping in place.
if ($ZipInPlace) {
    $Subfolders = (Get-ChildItem -Directory -Path $Src).Name
} else {
    $Subfolders = (Get-ChildItem -Directory -Path $Src -Exclude (Get-Item $Dest -ErrorAction SilentlyContinue).Name).Name
}

# Compress each subfolder's contents to a zip file of the same name in the output folder.
$Target = ""
foreach ($item in $Subfolders) {
    $Target = $Dest+"\"+$item+".zip"

    # Remove the target file if it already exists in the target directory to preserve deletions.
    if ((Test-Path $Target) -eq "True") {
        Remove-Item $Target
    }

    # Zip the file and store it in the target directory.
    & $7z a -tzip ($Target) ($SrcPath+"\"+$item+"\*") ("-x!"+$DestName)
}
