#!/bin/bash

score=0

questions=(
    "What is the capital of France?\n1) Paris\n2) London\n3) Rome\n4) Berlin"
    "What is the capital of Germany?\n1) Paris\n2) London\n3) Rome\n4) Berlin"
    "What is the capital of Italy?\n1) Paris\n2) Rome\n3) London\n4) Berlin"
    "What is the capital of Nigeria?\n1) Abuja\n2) Pretoria\n3) Nairobi\n4) Zambia"
    "What is the capital of USA?\n1) Lagos\n2) Washington DC\n3 Mexico\n4) Virginia"
    "What is the capital of England?\n1) Paris\n2) London\n3) Rome\n4) Berlin"
)

answers=(1 4 2 1 2 2)

for i in ${!questions[@]}; do
    echo -e "${questions[$i]}"
    read -p "Your answer: " answer

    if [ "$answer" -eq "${answers[$i]}" ]; then
        echo "Correct!"
        score=$((score + 1))
    else
        echo "Incorrect."
    fi
done

echo "Your final score is: $score"
