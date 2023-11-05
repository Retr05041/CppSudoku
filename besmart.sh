#! /bin/bash

Setup() {
    echo "Installing dependancies..."
    # Check if nvm is installed
    if ! [ -x "$(command -v nvm)" ]; then
        echo "Error: nvm is not installed." >&2
        echo "Insall nvm? (Y/n)"
        read -r install
        if [ "$install" = "Y" ] || [ "$install" = "y" ] || [ "$install" = "" ]; then
            echo "Installing nvm..."
            sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
            echo "Done!"
        else
            echo "Aborting..."
        fi
    fi
    nvm install 18
    nvm use 18
    nvm install -D tailwindcss
    # if there is no tailwind.config.js file, create one
    if ! [ -f "tailwind.config.js" ]; then
        echo "tailwind.config.js not found!"
        npx tailwindcss init
    fi
    echo "tailwind.config.js found!" 
    echo "Done!"
}

# Have tailwind watch for changes in a given file
TailwindWatch() {
    echo "Writing css file for $1..."
    # if tailw css file does not exist, create one
    if ! [ -f "./tailw.css" ]; then
        echo "tailw.css not found!"
        touch tailw.css
    fi
    npx tailwindcss -i ./tailw.css -o ./assets/styles/$1 --watch
}

build() {
    cmake -B build
    cmake --build build --config Release
}

rebuild() {
    cmake -B build
    cmake --build build --config Release --clean-first
}

if [ "$1" == "build" ]; then
    build
elif [ "$1" == "rebuild" ]; then
    rebuild
elif [ "$1" == "run" ]; then
    build
    ./build/MyApp
elif [ "$1" == "setup" ]; then
    Setup
elif [ "$1" == "watch" ]; then 
    TailwindWatch $2
else
    echo "Usage: ./besmart.sh [build|run]"
fi