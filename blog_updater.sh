#! /bin/bash

echo -n "Checking repository..."

LAST_SIZE=$(du -sbc | grep -o '^[0-9]\+' | head -n 1)
git pull &>/dev/null
NEW_SIZE=$(du -sbc | grep -o '^[0-9]\+' | head -n 1)

if [ $NEW_SIZE != $LAST_SIZE ]; then
        echo -n " found changes! rebuilding..."
	./jekyll_build.sh &>/dev/null
	RESULT=$?
	
	if [ $RESULT -eq 0 ]; then
		echo -n " done! uploading..."
		cd _site
		tar czf - * | ssh manitu "cd kbaraniak.com && tar xzf -"
		RESULT=$?
		if [ $RESULT -eq 0 ]; then
			echo " Done! Sending a telegram message and exiting then."
			python3 /home/kev/telegram_messager/send_telegram_message.py breekon Kevin "Blog updated :)"
		else
			echo " Failed! :( exiting"
			exit 1
		fi
	else
		echo -n " Failed! :( exiting."
		exit 1
	fi
else
	echo " detected no changes, exiting."
fi
