# Run the vbox.ps1 as Administrator to install virtualbox
powershell -ExecutionPolicy RemoteSigned -File C:\Users\Public\Downloads\cuck00-script\vbox.ps1

# Download Ubuntu20.04 ISO image file if the Ubuntu 20.04 ISO file is not exist
if(Test-Path -Path C:\Users\Public\Downloads\Ubuntu20.04.iso) {
Write-Host "The Ubuntu ISO image file is ready"
}
else{
Invoke-WebRequest http://old-releases.ubuntu.com/releases/20.04/ubuntu-20.04-desktop-amd64.iso -Outfile C:\Users\Public\Downloads\cuck00-script\Ubuntu20.04.iso
}

# Create ubuntu vm

# Set parameters:1. machinename: vm name, 2. basefolder: virtual machine folder path
param ($machinename, $basefolder)

# Create VM
VBoxManage createvm --name $machinename --ostype "Ubuntu_64" --register --basefolder $basefolder

# Set memory and network
VBoxManage modifyvm $machinename --ioapic on
VBoxManage modifyvm $machinename --memory 4096 --vram 128
VBoxmanage modifyvm $machinename --nic1 nat

# Create Disk and connect Ubuntu ISO
# Add SATA controller
VBoxManage storagectl $machinename --name "SATA Controller" --add sata --controller IntelAhci --bootable on

# Add IDE controller
VBoxManage storagectl $machinename --name "IDE Controller" --add ide --controller PIIX4 --bootable on

# Add hard disk and associate to controller
VBoxManage createhd --filename $basefolder/$machinename/$machinename.vdi --size 100000 --format VDI
VBoxManage storageattach $machinename --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium  $basefolder/$machinename/$machinename".vdi"

# Add CD-ROM and mount the image file
VBoxManage storageattach $machinename --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "C:\Users\Public\Downloads\cuck00-script\Ubuntu20.04.iso"
VBoxManage modifyvm $machinename --boot1 dvd --boot2 disk --boot3 none --boot4 none

#Enable RDP
VBoxManage modifyvm $machinename --vrde on
VBoxManage modifyvm $machinename --vrdemulticon on --vrdeport 10001

# Enable Nested VT-x/AMD-v
 VBoxManage modifyvm $machinename --nested-hw-virt on

# start vm
VBoxManage startvm $machinename
