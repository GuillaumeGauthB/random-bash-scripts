#
#		Script that allows you to delete files and folders through it, kinda useless but was a test anyway
#


user="/home/$(whoami)/"
folderSelection () {
	echo Where are the files you want to delete?

	read -p "$user" locationChoice

	locationDelete="$user$locationChoice"
	
	testFolderSelection
}

testFolderSelection () {
	echo Current location: $locationDelete

	echo Is this right?

	read -p "y/n: " yesOrNo

	if [ "${yesOrNo,,}" == "y" ]; then
		folderReading	
	elif [ "${yesOrNo,,}" == "n" ]; then
		folderSelection
	else
		echo Answer not acceptable, answer with "y" or "n"
		testFolderSelection
	fi

}

folderReading () {
	echo List directory content in TREE format or LIST format?

	read -p "tree/list: " treeLs

	if [ "${treeLs,,}" == "tree" ]; then
		listChoice="tree -laL 3"
	elif [ "${treeLs,,}" == "list" ]; then
		listChoice="ls -la"
	else
		echo Answer not acceptable, try again
		folderReading
	fi

	cd $locationDelete && $listChoice

	echo Which files do you want to delete?
	
	deleteSelection
}

deleteSelection () {
	read -p "File/folder to delete: " wantToDelete
	
	if [ "$wantToDelete" == "*" ]; then
		toDelete="$wantToDelete"
		echo "Are you sure you want to delete all files of said type in $locationDelete?"
		delete
	else
		if [[ -z "$toDelete" ]]; then
			toDelete="$wantToDelete"
		else
			toDelete+=" $wantToDelete"
		fi
		toDelete = "$wantToDelete"
		echo Currently selected: $toDelete
		echo Select more?
		read -p "y/n: " selectMoreYN
		if [[ "${selectMoreYN,,}" == "y" ]]; then
			deleteSelection
		elif [[ "${selectMoreYN,,}" == "n" ]]; then
			echo Are you sure you do not want to delete anything else?
			delete
		else
			echo Answer not acceptable, answer with "y" or "n"
			deleteSelection
		fi
	fi
}

delete () {
	read -p "y/n: " answerDelete
	if [ "${answerDelete,,}" == "y" ]; then
		echo Put in the trash directory or permanently delete?
		read -p "Trash/Permanent : " deleteType
		if [ "${deleteType,,}" == "Trash" ]; then
			echo Transfering all file selected to the trash directory
			rsync -rv $toDelete ~/.local/share/Trash/files
			rm -rfv $toDelete
			echo; echo
			echo Succesfully moved all files to the Trash folder
		elif [ "${deleteType,,}" == "Permanent" ]; then
			echo Permanently deleting all selected files
			rm -rvf $toDelete
			echo; echo
			echo Succesfully deleted all files
		fi
	elif [ "${answerDelete,,}" == "n" ]; then
		deleteSelection
	else
		echo Answer not acceptable, answer with "y" or "n"
		delete
	fi
}
folderSelection
