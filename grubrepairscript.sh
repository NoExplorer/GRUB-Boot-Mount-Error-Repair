#! /bin/bash
# Automated program that aims to repair a very annoying problem (for me).
# You know grub, you know the /boot partition. Well that sometimes isnt mounted correctly
# by grub. And that is annoying. I hope that I can automate the repair process with this.
# No promises though.

# Run lsblk command to list all partitions.
lsblk
# Ask the user to input the partition/disk where Arch is installed to
echo "Please input your partition where Arch is installed to (do NOT include the number. Like just /dev/sdx [Where X is the partition])"
# Var to put the partition info to
read -r TOREPAIR
# Informing the user on which partition they selected
echo "You selected the partition", "$TOREPAIR", ". DOUBLE CHECK that this is the partition."
# Assuming the user hasn't changed directory after chrooting, we can begin the re-installation of the kernel images.
# NOTE: This will install the MOST RECENT version of the kernels. So if the user needs an older one, I'll have to work
# this again. I'd recommend the most new ones, unless they depend on old versions. They can install those with ease
# from the repaired OS (if this script works that is). The following prompt asks the user if they want to also reinstall
# the LTS kernel.
echo "Do you want the LTS kernel to be (re)installed? [Y for yes , N for no]"
# var that holds the answer
read -r LTSYAYORNAY
# if statement to check if they want it
if ! [ "$LTSYAYORNAY" = N ]
then
    echo "You selected to re-install BOTH LTS and Standard Linux Kernel images"
    pacman -Syu linux linux-lts
else
    echo "You selected to re-install ONLY Standard Linux Kernel image"
    pacman -Syu linux
fi
# Okay, step one done. mkinitcpio is useless but in a case its needed, the user can say so. The command is ran automatically when installing the kernels
echo "Do you want to run the mkinitcpio command? (It is not always required to fix GRUB, but in case it didn't say so and it will run. [Hint: its ran automatically when installing the kernels])"
# Var that holds the answer
read GETFREEINITCPIOANYWHEREYOUGO
# VERY IMPORTANT: Since we got an if statement which does a different update command, its needed here too. But first
# Let's see if they want free initcpio anywhere they go
if ! [ "$GETFREEINITCPIOANYWHEREYOUGO" = N ]
then
    echo "Continuing with the command.."
    if ! [ "$LTSYAYORNAY" = N ]
    then
        echo "Installing BOTH LTS and Standard Linux Kernel images"
        mkinitcpio -p linux linux-lts
    else
        echo "Installing ONLY Standard Linux Kernel image"
        mkinitcpio -p linux
    fi
else
    echo "Continuing without running command.."
fi
# Informing the user that the GRUB re-constructuring process is about to begin..
echo "Beginning GRUB Repair process. DO NOT UNPLUG OR REMOVE POWER ACCESS TO THE COMPUTER! IT MAY SCREW THINGS UP!"
# Step one: Fix config file..
echo "Fixing GRUB config file.."
grub-mkconfig -o /boot/grub/grub.cfg
# Step two: Re-install GRUB
echo "Re-installing GRUB to partition", "$TOREPAIR", ".."
grub-install $TOREPAIR
# Inform that it is done.
echo "Repair complete! Check that everything finished without errors (Especially the GRUB Installation part.)"
echo "You should be OK to reboot after you exit the chroot. Hope that this script fixed the issue."