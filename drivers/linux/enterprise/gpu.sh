# For GPU we need specific version
header "Kernel"
KERNEL_VERSION=$(uname -r)
WANTED_KERNEL_VERSION="5.4.0-42-generic"
if [ $KERNEL_VERSION != $WANTED_KERNEL_VERSION ]
then
    echo "Found kernel $KERNEL_VERSION wanted $WANTED_KERNEL_VERSION"

    IMAGE="linux-image-${WANTED_KERNEL_VERSION}"
    HEADERS="linux-headers-${WANTED_KERNEL_VERSION}"
    MODULES_EXTRA="linux-modules-extra-${WANTED_KERNEL_VERSION}"

    sudo apt install $IMAGE $HEADERS $MODULES_EXTRA

    echo ""
    echo "installed $WANTED_KERNEL_VERSION which is the latest supported kernel by amdgpu";
    echo "please reboot into this kernel and re-run this script"

    exit 1;
else
    sudo apt remove linux-image-5.4.0-58-generic linux-image-unsigned-5.4.0-58-generic
    audo apt autoremove
fi

# tests GPU, when required install GPU drivers
if ! command -v amdgpu-uninstall --help &> /dev/null
header "GPU"
then
    echo "Please install GPU drivers"
    echo "Install GPU drivers, download it from please go to: https://www.amd.com/en/support/graphics/. Download drivers, unpack and run it with sudo ./amdgpu-install -y"
else
    echo "GPU drivers are installed"
fi


sudo apt --fix-broken install

sudo apt install -y update
sudo apt install -y upgrade
sudo apt install -y full-upgrade
sudo apt install -y build-essential
