#!/bin/bash
#Author: CaptainCluster https://github.com/CaptainCluster

#The program saves the collection (array) into a .txt file.
saveCollection(){
    local videoGameCollection=$1 #The array
    local saveFile=$2 #The file the contents are saved into

    #We will add all the contents of the array that was passed as an argument.
    #The file's original content will be replaced, as the array is programmed
    #to hold the previous content.

    for game in "${videoGameCollection[@]}"; do
        echo -e "$game" > "$saveFile"
    done
}

loadCollection(){ 
    local videoGameCollection=() #Defining a new array to use
    local saveFile="collection.txt"

    #We'll use a while-loop to add the contents of the file, line by line,
    #into the array.
    while IFS= read -r line; do 
        videoGameCollection+=("$line")
    done < "$saveFile"

    printf "%s\n" "${videoGameCollection[@]}" #At last, we shall return the array
}
