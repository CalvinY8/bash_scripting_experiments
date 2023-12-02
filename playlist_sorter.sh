#!/bin/bash
file="playlist.txt"
#bash script to read a "playlist.txt" file in the current directory

#gives you two options
#sort playlist alphabetically by artist
#sort playlist alphabetically by song title

#playlist.txt needs a newline character or empty line at the end of the file
#https://stackoverflow.com/questions/12916352/shell-script-read-missing-last-line

#playlist.txt is arranged artist_name - song_name, that's how the software delimits or tells apart the names
#might want to add some error checking if playlist.txt does not exist


#need to define functions before calling
sort_by_artist () {
	printf "\ncalling sort_by_artist \n"
	sort $file -o $file #output saved to file instead of default behavior of printing result
}


sort_by_song_name () {
	printf "\ncalling sort by song_name \n"
	
	#https://www.unix.com/shell-programming-and-scripting/75478-sort-entire-line-based-part-string.html
	#https://stackoverflow.com/questions/50211598/how-to-sort-lines-based-on-specific-part-of-their-value
	
	#specify the delimiter with t
	# artist & song name are delimited by dash (-)
	# field 1   field 2
	# eminem   rabbit run
	
	#specify the fields to sort by with k
	# 2,2, specifies sorting from the start of the 2nd field to the end of the 2nd field
	# treats fields as strings by default

	sort -t '-' -k 2,2 $file -o $file
}


#=bash menu=
PS3='your choice: ' #PS3 is the prompt for the select command

a="sort playlist alphabetically by artist"
b="sort playlist alphabetically by song title"
c="quit"

choices=("$a" "$b" "$c")
#wrap quotes around (variables with spaces) when deferencing

select choice in "${choices[@]}"
do
	case $choice in
	"$a")
		printf "1...$a"
		sort_by_artist #calling fn
		break
		;;
	"$b")
		printf "2...$b"
		sort_by_song_name #calling fn
		break
		;;
	"$c")
		printf "3...$c"
		break
		;;
	*)
		echo "invalid choice"
		;;
	esac
done
