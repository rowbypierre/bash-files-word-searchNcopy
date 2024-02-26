# Description
This script is a shell script designed to search for a specific keyword in files within directories, copy the files containing the keyword to a specified folder, and append information about the occurrences of the keyword to the copied files. 

# Demo
[`Click here`](https://www.dropbox.com/scl/fi/2csz4xu5wmilmsjfaekcy/file-search-test-20240204.mp4?rlkey=s8td5aa3doxtqysp3rwvsejvh&dl=0)
# Functionality

1. **Prompt for Keyword:** The script starts by asking the user to enter a keyword that will be searched in files.
	```python
    	read -p "Enter keyword to search in files: " key
	```

2. **Prompt for Destination Folder:** The user is then asked to enter the name of a folder where files containing the keyword will be copied.
	```python
	read -p "Enter folder to copy files containing keyword: " cpfolder
	```
3. **Check and Create Destination Folder:** The script checks if the specified folder exists. If it doesn't, the folder is created.
	```python
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
	```
4. **Search Through Directories:**
	- The script uses the `find` command to list all directories starting from the current directory.
	```python
        DirS=$( find . -type d )
	```
	- It then iterates through each directory.
	```python
        for dir in $DirS ; do
	```
5. **Exclude the Destination Folder:** If the current directory in the loop is not the destination folder, the script proceeds to search within it.
	```python
        if [ "$dir" != $cpfolder ] ; then
	```
6. **Search Files in the Directory:**

    - The script iterates through each file in the current directory.
    - For each file, it checks if the file is a regular file (not a directory or a special file).
	```python 
        for file in "$dir"/* ; do 
            if [ -f "$file" ] ; then
                echo "File: $file scanning.. "
	```
7. **Search for Keyword in File:**

- The script uses `grep` to search for the keyword in the file.
	```python
        checker=$( grep -ni "$key" "$file" )
	```
- If the keyword is found (grep output is not empty), the following actions are taken:
   - The filename is extracted using `basename`.
    	```python
    	fileN=$( basename "$file" )
    	```
   - Information that the file contains the keyword is displayed.
    	```python
    	echo "$fileN HAS keyword"
    	```
   - The file is copied to the destination folder.
    	```python
    	cp "$file" "$cpfolder/$fileN"
    	```
   - A separator line and the output of `grep` (which includes the line number and the line content where the keyword was found) are appended to the end of the copied file.
    	```python
    	echo "*****************************" >> "$cpfolder/$fileN"
    	echo "$checker" >> "$cpfolder/$fileN"
    	echo "Line and line number for cooresponding keyword appended to copied $fileN"
    	```
   	- A message is displayed indicating that the line and line number where the keyword was found are appended to the file.
    	```python
    	echo "Line and line number for cooresponding keyword appended to copied $fileN"
    	```
8. **Handle Files Without Keyword:** If the keyword is not found in a file, a message is displayed indicating that the file does not contain the keyword.
	```python
    echo "$fileN DOES NOT have keyword"
	```
9. **End of Directory Iteration:** After completing the search in a directory, a separator line is printed before moving to the next directory.
	```python
    echo "------------------------------------------------------------------------------------------"
	```
