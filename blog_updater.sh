#! /bin/bash

LAST_SIZE=$(du -sbc | grep -o '^[0-9]\+' | head -n 1)
echo "Last size: $LAST_SIZE"
 
git pull

NEW_SIZE=$(du -sbc | grep -o '^[0-9]\+' | head -n 1)

echo "New size: $NEW_SIZE"

if [ $NEW_SIZE != $LAST_SIZE ]; then
        ./jekyll_build.sh
	cd _site
	tar czf - * | ssh manitu "cd kbaraniak.com && tar xzf -"
	python3 /home/kev/telegram_messager/send_telegram_message.py breekon Kevin "Blog updated :)"
fi
