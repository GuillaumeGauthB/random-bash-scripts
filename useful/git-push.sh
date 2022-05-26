#!/bin/bash
# Script to automatically push

# Command not found

# Function to add files to commit
addFile () {
    # tree $(git rev-parse --show-toplevel)
    echo "Modified files:"
    echo ""
    git ls-files -m
    echo "__________________"
    echo "Untracked Files:"
    echo ""
    git ls-files --others --exclude-standard
    echo "__________________"
    echo ""
    echo "__________________"
    echo ""
    echo "What do you want to add?"
    echo "PS: for now only works with a single added element"
    read toAdd
    if [[ "$(tree)" == *"not found"* ]]; then
        echo "Tree command not found"
        # list all directories in folder
        # for every directory, execute a command that checks for other directories and executes a function on all of them, that will
        # reexecute the function 
        # 
    elif [[ "$toAdd" != "" || "$(git ls-files -m | grep $toAdd )" != "" || "$()git ls-files --others --exclude-standard | grep $toAdd" != "" ]]; then
        IFS=' ' read -r -a toAddArray <<< "$toAdd"
        for item in "${toAddArray[@]}"; do
            echo "$item"
            if [[ "$(find ~+ -name $item)" != "" ]]; then
                echo $(find ~+ -name $item)
                git add $(find ~+ -name "$item")
            fi
        done
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

