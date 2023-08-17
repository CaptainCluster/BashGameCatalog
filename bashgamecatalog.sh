#!/bin/bash
#Author: CaptainCluster https://github.com/CaptainCluster

#mainFunction is the function that is started initially
mainFunction(){
    source src/savemanager.sh
    source src/exceptions.sh

    videoGameCollection=$(loadCollection)

    while true #Iterating the loop, allowing the user to manage the collection with ease
    do
        optionSelection="1) Add a game to the collection, 2) Remove a game from the collection, 3) Display the collection, 4) Backup collection, 5) Copy backup to main save file, 0) Shutdown: "
        read -p "$optionSelection" option

        #Next we will handle the processes for the following cases: 1, 2, 3, 4, 5, 0, everything else (exception)
        case $option in 
            1)
                videoGameCollection=$(addToCollection "${videoGameCollection[@]}")
                saveCollection "${videoGameCollection[@]}" "save_files/collection.txt"
                ;;
            2)
                removeFromCollection "${videoGameCollection[@]}"
                videoGameCollection=$(loadCollection) #We can load to update the array
                ;;
            3)
                displayCollection
                ;;
            4)
                saveCollection "${videoGameCollection[@]}" "save_files/backup.txt"
                ;;
            5)
                cp "save_files/backup.txt" "save_files/collection.txt"
                videoGameCollection=$(loadCollection)
                ;;
            0)
                echo "Ending the program."
                exit 0
                ;;
            *)
                echo "Invalid input. Try again."
                ;;
        esac
    done
}

#When the user adds a video game into their collection, the program will ask for the title of the game,
#the platform(s) the user plays the game on and other potential notes.
addToCollection(){
    videoGameCollection=$1 #Receiving an array as a parameter

    #Next we declare a video game "object" with the following attributes: title, platform(s)
    declare -A videoGame 
    #The user will give the title and the platform(s)
    read -p "Enter the title: " videoGame[title]
    read -p "Now give the platform(s) you play it on: " videoGame[platforms]

    #Every game will be displayed in the following format:
    #Video Game Title ; Video Game Platform(s)
    videoGameInfo="${videoGame[title]} ; ${videoGame[platforms]}" 

    videoGameCollection+=("$videoGameInfo") #Adding the video game into the collection

    printf "%s\n" "${videoGameCollection[@]}" #Returning the collection
}

#Removes games from the collection based on a pattern given by the user
removeFromCollection(){
    videoGameCollection=$1
    temporaryHolder="save_files/temporary.txt"
    saveFile="save_files/collection.txt"

    read -p "What game shall we remove: " pattern 
    condition=$(checkPattern "$pattern")

    if [[ $condition == "true" ]]; then
        #Deleting lines that contain the given pattern and moving the contents to a temporary file
        sed "/$pattern/d" "$saveFile" > "$temporaryHolder"
        #Now the temporary file should contain everything that we didn't want to remove.
        #Now we will put the content to the main save file, allowing us to use it.
        mv "$temporaryHolder" "$saveFile"
    else
        #If the pattern is invalid, we will halt the removal process.
        echo "Make sure you type a valid pattern next time!"
    fi    
}

#Echoing the entire collection using echo
displayCollection(){
    for game in "${videoGameCollection[@]}"; do
        echo -e "$game"
    done
}


mainFunction