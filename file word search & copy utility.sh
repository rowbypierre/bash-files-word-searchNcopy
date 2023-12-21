#! /usr/bin/bash

echo"
This file will do the following:
	1. Read and store keyword from user.
	2. Read and store folder name from user.
		2-a. Determine if input provided exist in current working directory.
		2-b-1. Create folder if folder does not exist in current directory.
		2-b-2. Use existing folder to copy files.
	3. Search keyword against all files recursively.
	4. Files containing keyword will be copied to folder (2).
	5. Line and line numbers will append to copied file (5).  "
echo
read -p "Enter keyword to search in files: " key
echo
echo "Files will be seached for: $key"
echo
read -p "Enter folder to copy files containing keyword: " cpfolder
echo
if [ ! -d "$cpfolder" ] ; then
	mkdir "$cpfolder"
	echo "Folder: $cpfolder does not already exist"
	echo
	echo "Folder: "$cpfolder" has been created"
	echo
else 
	echo "Copied files will exist in: $cpfolder"
	echo
fi

DirS=$( find . -type d )
for dir in $DirS ; do

	if [ "$dir" != $cpfolder ] ; then

		echo "*******************FOLDER: $dir***********************"

		for file in "$dir"/* ; do 
			if [ -f "$file" ] ; then
				echo "File: $file scanning.. "
				echo

				checker=$( grep -ni "$key" "$file" )

				if [ ! -z $checker ] ; then
					fileN=$( basename $file )
					echo "$fileN HAS keyword"
					echo

					cp "$file" "$cpfolder/$fileN"
					echo "$fileN COPIED to $cpfolder"
					echo
			
					echo "*****************************" >> "$cpfolder/$fileN"
					echo "$checker" >> "$cpfolder/$fileN"
					echo "Line and line number for cooresponding keyword appended to copied $fileN"
					echo
				else
					echo "$fileN DOES NOT have keyword"
					echo
				fi
			fi
		done
	fi
	echo "------------------------------------------------------------------------------------------"
	echo
done
