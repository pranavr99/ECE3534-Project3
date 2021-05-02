#! /bin/bash

thisscriptname="${0##*/}" # name of this script file

# Make this script an executable for the user
chmod +x "$thisscriptname"

# Arguments: Root of directory tree, output filename

# This is essential as the given rootname can be in any subdirectory within the current directory's tree
#rootpath="$(find . -type d -name "${1##*/}")" # finding the path of the given
#echo "$rootpath" # Debugging purposes

#rootname="${rootpath}" # First arg is the root of the directory tree
rootname="${HOME}" # First arg is the root of the directory tree..per proj3 req.

#outfile="${2##*/}" # Second arg is output filename
outfile="$(pwd)/filetree.html" # Second arg is output filename... per proj3 req..
outfilename="filetree.html"	#-- need for proj3...

#echo $rootname
#echo $outfile
#echo $outfilename


#-- Deal with the target file... ------
if [ ! -f $outfilename ]; then	#-- chk if the target file exist...

    touch $outfilename		#-- create new file...

else				#-- looks like it already exist - remove it...
    chmod +rwx $outfilename
    rm $outfilename
    touch $outfilename
fi
#-------------------------------------


echo
echo "==========================================="
echo " ECE3524 - Project 1: Intro to Unix "
echo " This script will traverse directory supplied as an argument."
echo " It will output a site map to an HTML file. "
echo "==========================================="
echo
echo "This file		:$thisscriptname"
echo "Starting directory	:$rootname"
echo "Output file		:$outfile"


#---------------------------------------
# Function definition to loop thru directory structure...
#---------------------------------------
loopDir () {

    IFS=$'\n'  #-- InternalFieldSeparator(IFS) - will hold '\n' - newline character as delimeter,so dir/fil names are not modified...
    root=$1	#-- 1st arg to this function... current folder we are checking...
    outfile=$2	#-- 2nd arg to this function...

   # echo $root
   # echo $outfile

    if [[ -d "$root" && -r "$root" ]]; then #-- is this a valid folder, i.e. it is a readable directory

        #-- chk if a folder is readable then proceed
        if [[ -r "$root" ]]; then

            if find "$root" -mindepth 1 | read; then #-- if the folder/directory isn't empty...

                echo "<ul>">>"${outfile}"	#-- insert ul marker in output file...

                for file in "$root/"*;		#-- loop thru the files in this folder...
                do
                    if [[ -d "${file}" ]]; then	#-- if this is a folder - print folder name in bold to file and call traverse func again...

                        echo "<li> <b> ${file##*/} </b> </li>">>"${outfile}"

                        loopDir $file $outfile	#-- calling traverse func with args: this folder name, outputfilename...

                    else			#-- it is not a folder but a file, don't print '<li>' marker - just call traverse func...

                        loopDir $file $outfile
                    fi
                done

                echo "</ul>">>"${outfile}"	#-- closing '<ul>' marker and saving to outputfile...
            fi
        fi
    else					#-- this is not a folder, just add '<li>' elem to output file...

        if [[ -r "$root" ]]; then 		#--just in case,  chk if this file is readable...

            echo "<li> ${root##*/} </li>">>"${outfile}"
        fi
    fi

} #--e-o-func ...
#---------------------------------------------

#----- MAIN BODY ----------------------------

if [[ -d "$rootname" && -r "$rootname" ]]; then #-- Chk if the initial starting directory/folder is valid and readable...

    #-- Creating the HTML File...

    echo "<!DOCTYPE html>">>$outfilename
    echo "<html>">>$outfilename
    echo "<!body>">>$outfilename
    echo "<h1> Directory Tree </h1>">>$outfilename

    loopDir $rootname $outfile		#-- first time loop function call...

fi
echo
echo "Output file generated sucessfully. Double-click to view in the browser."
echo

#-------------------------------------------

