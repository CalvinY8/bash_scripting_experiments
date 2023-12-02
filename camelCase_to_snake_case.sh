#!/bin/bash

#toggle commenting for selected lines on with Ctrl + Q

#USAGE
#the supposed use of this script is that camelCase is faster to type
#but snake_case is more legible
#This script renames any files (in current working directory) with titles in camelCase to snake_case
		
echo "current directory"
echo "$PWD"

echo #empty line for legibility between printouts
echo "contents of current directory"
IFS=$'\n' #for in $() splits based on IFS.
: '
Internal Field Separator (IFS) by default is a space.
Filenames with spaces would break this logic.
So the IFS is custom set to be newline character.
'
search_dir="$PWD"
for entry in $(ls $search_dir)
do
	echo $entry
	
	#get the file ending
	full_filename=$(basename -- "$entry")
	extension="${full_filename##*.}"
	filename="${full_filename%.*}"
	#echo $extension
	
	is_txt=$(expr $extension == "txt")


	#https://unix.stackexchange.com/questions/44337/oneliner-to-detect-camelcase-variables
	#https://stackoverflow.com/questions/35919103/how-do-i-use-a-regex-in-a-shell-script
	regex_camel_case='([a-z]{1,}[A-Z])|(^.+[A-Z]{1,}[a-z])'
	if [[ $filename =~ $regex_camel_case ]]
	then
		is_camel_case=1
	else
		is_camel_case=0
	fi
	#I feel like the above if statement could be made into one line
	#but every time I try something breaks
	
	
	#echo "filename matches regex? " $is_camel_case

	
	if (( $is_txt && $is_camel_case ))
	then
		#echo "this is a txt file and is camelCase"
		
		#generate the snake_case name
		#https://stackoverflow.com/questions/63355860/camelcase-to-snake-case-using-the-shell
		#https://stackoverflow.com/questions/52058721/convert-camelcase-to-lower-and-underscore-case-using-bash-commands
		#this is an example of command substitution
		snake_case_filename=$(sed 's/^[[:upper:]]/\L&/;s/[[:upper:]]/\L_&/g' <<< $full_filename)
		
		echo "rename this file to: " $snake_case_filename
		
		#finally, rename the file. Only do this if all other logic is verified.
		#https://linuxhint.com/rename_file_bash/
		
		 # Rename the file
		 $(mv $full_filename $snake_case_filename)
	
	fi
done
