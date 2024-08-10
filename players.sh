#!/bin/bash

# File to store player information
player_file="players.txt"

# Function to initialize the player file
initialize_file() {
    if [ ! -f "$player_file" ]; then
        touch "$player_file"
    fi
}

# Function to add a new player
add_player() {
    echo "Enter player name:"
    read player_name

    if grep -q "^$player_name" "$player_file"; then
        echo "Player $player_name already exists."
    else
        echo "$player_name:0" >> "$player_file"
        echo "Player $player_name added with a score of 0."
    fi
}

# Function to remove a player
remove_player() {
    echo "Enter player name to remove:"
    read player_name

    if grep -q "^$player_name" "$player_file"; then
        grep -v "^$player_name" "$player_file" > temp.txt && mv temp.txt "$player_file"
        echo "Player $player_name removed."
    else
        echo "Player $player_name does not exist."
    fi
}

# Function to list all players and their scores
list_players() {
    echo "List of players and their scores:"
    if [ -s "$player_file" ]; then
        cat "$player_file"
    else
        echo "No players found."
    fi
}

# Function to play the quiz game and update the player's score
play_quiz() {
    echo "Enter player name:"
    read player_name

    if grep -q "^$player_name" "$player_file"; then
        # Source the quiz game script
        source ./quiz_game.sh

        # Call the quiz_game function
        new_score=$?

        # Update the player's score
        current_score=$(grep "^$player_name" "$player_file" | cut -d ':' -f 2)
        updated_score=$((current_score + new_score))

        # Replace the old score with the updated score
        sed -i "s/^$player_name:.*/$player_name:$updated_score/" "$player_file"
        echo "Updated score for $player_name is $updated_score."
    else
        echo "Player $player_name does not exist."
    fi
}

# Main menu
while true; do
    echo "Player Management System"
    echo "1. Add Player"
    echo "2. Remove Player"
    echo "3. List Players"
    echo "4. Play Quiz Game"
    echo "5. Exit"
    echo "Select an option (1-5):"
    read option

    case $option in
        1) add_player ;;
        2) remove_player ;;
        3) list_players ;;
        4) play_quiz ;;
        5) exit ;;
        *) echo "Invalid option. Please select a number between 1 and 5." ;;
    esac
done
