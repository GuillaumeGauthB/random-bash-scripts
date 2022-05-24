#!/bin/bash
# Script to automatically push

# Function to add files to commit
addFile () {
    tree $(git rev-parse --show-toplevel)
        echo ""
        echo "__________________"
        echo ""
        echo "What do you want to add?"
        echo "PS: for now only works with a single added element"
        read toAdd
        if [[ "$toAdd" != "" || "$(tree $(git rev-parse --show-toplevel) | grep $toAdd )" != "" ]]; then
            echo "$(find ~+ -name $toAdd)"
            git add $(find ~+ -name $toAdd)
            # Problem: only works if there is one file or folder
            # Might have to use awk in order to check the amount of parameters
            # Then sed to cut the string up by spaces, put it in an array, and run the command for everything
            # with a for or foreach or smth
        elif [[ "$toAdd" == "." ]]; then
            git add .
        else
            echo "File or folder does not exist, try again"
            addFile
            return 1
        fi
        read -p "Commit name: " commitName
        git commit -m "$commitName"
        pushFile
}

# Function to set where to push
pushFile () {
    git remote
    echo "Select remote, or enter no to enter a custom url"
    read userRemote
    if [[ "${userRemote,,}" == "no" ]]; then
        read -p "URL: " urlRemote
        userRemote=urlRemote
    elif [[ "$(git remote | grep $userRemote)" != "$userRemote" && "${userRemote,,}" != "no" ]]; then
        echo "Remote does not exist"
        pushFile
        return 1
    fi
    pushFileBranch
    
}

# Function to set the branch to push to
pushFileBranch () {
    read -p "Branch to push on: " userBranch
    if [[ userBranch != "" ]]; then
        git push "$userRemote" "$userBranch"
    else
        echo "Enter a branch name"
        pushFileBranch
        return 1
    fi
}

# cd $(pwd)

if [[ $1 == "" || $2 == "" || $3 == "" ]]; then
    echo "Required parameters not present"
    read -p "User CLI interface? (Y/n)" theChoice
    if [[ "${theChoice}" == "" || "${theChoice,,}" == "y" ]]; then
        addFile
        
    else
        echo "Exitting"
    fi
else
    git add --all && git commit -m "$1" && git push $2 $3
fi

