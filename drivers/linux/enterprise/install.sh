# ask password upfront
echo
echo "User password required to install packages"

sudo -v

# test internet connection, if not found install ethernet drivers
echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    clear
    echo
    echo "Starting install..."

    source ./fetch-packages.sh
    source ./gpu.sh
else
    header "No internet detected, installing ethernet drivers"

    source ./internet.sh
fi
