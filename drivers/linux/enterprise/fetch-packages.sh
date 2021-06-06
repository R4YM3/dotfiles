echo "make download packages script to  run on other computer"
sudo apt-get -qq --print-uris install build-essential linux-headers-$(uname -r) | cut -d\' -f 2 > urls.txt

echo "copy urls.txt to other computer and download all urls, with \"wget < urls.txt\""

echo "copy all packages over and install"
sudo cp /media/YOUR_USERNAME/THUMBDRIVE_NAME/deb/* /var/cache/apt/archives/
sudo apt-get install build-essential linux-headers-$(uname -r)
