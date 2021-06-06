# test internet connection, if not found install ethernet drivers
echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    clear
    echo
    echo "Starting install..."
else
    header "No internet detected, installing ethernet drivers"

    source ./dongle.sh

    # TODO?
    #
    # download r8125-9.004.01  and install it..


    # echo "Installing driver dependecies"
    # sudo dpkg -i ./drivers/ethernet/dependecies/*


    # sudo chmod +x ./drivers/ethernet/r8125-9.004.01/autorun.sh
    # cd ./drivers/ethernet/r8125-9.004.01/ && sudo ./autorun.sh

    # echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
    # if [ $? -eq 0 ]; then
    #   clear
    #    echo
    #    echo "Connected to Internet."
    # else
    #    echo
    #    echo "ERROR: No internet detected"
    #    exit 1
    # fi
fi

sudo apt --fix-broken install

sudo apt install -y update
sudo apt install -y upgrade
sudo apt install -y full-upgrade
sudo apt install -y build-essential
