#! /bin/bash

LAST_SIZE=$(du -bsc)
echo "Last size: $LAST_SIZE"

git pull

NEW_SIZE=$(du -bsc)

echo "New size: $NEW_SIZE"

if [ $NEW_SIZE = $LAST_SIZE ]; then
        echo "Change detected"
        #./jekyll_build.sh
fi

