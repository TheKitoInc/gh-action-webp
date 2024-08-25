#!/bin/sh

test -z "${IMAGE_EXTENSIONS}" && exit 1

PATH_ROOT=$(git rev-parse --show-toplevel 2> /dev/null) || exit 2

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update || exit 3
sudo apt-get install -y webp || exit 4

cd "$PATH_ROOT" && \
git fetch && \
git pull || exit 5

for extension in $(echo "$IMAGE_EXTENSIONS")
do
    echo "Converting images with extension $extension to WebP format"
    
    for src in $(find "$PATH_ROOT" -type f -iname "*.$extension" -exec echo "{}" \;)
    do
        dst=$(echo "$src" | sed 's/\.[^.]*$//')
        
        if [ "$src" -nt "$dst" ]
        then
            echo "Converting $src to $dst.webp"

            cwebp -q 100 "$src" -o "$dst.webp"
        fi        
    done

    git add . && \
    git commit -m "Convert images with extension $extension to WebP format"
done

git push || exit 7