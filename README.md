# ![image](https://user-images.githubusercontent.com/37076999/210605395-d7e2b712-ca4e-4ccc-ab28-8ed1ab0df17c.png) /boot Error during boot repair script.
GRUB sucks sometimes. BASh script that could fix it automatically.
<p>&nbsp;</p>

# Elaborate please
![image](https://user-images.githubusercontent.com/37076999/210595815-d1fea046-d218-4681-911d-c914fb5779a4.png)

### I am talking about this specific error. I have seen it so many times that I have grown tired of manually fixing this. With this BASh script I aim to automate the second half of the repair process.
<p>&nbsp;</p>

# Installation
### There is no real installation process. Just download the file and you are done.
### **BEWARE:** You must place this file in ***the root folder of your Arch Linux installation!*** For example:
![image](https://user-images.githubusercontent.com/37076999/210598412-b51f53cd-09d1-45c2-99bc-2e5f7e638bbe.png)

### Where you store the script is important. This is because. when you chroot into an existing installation, you mount to your **Root Account Partition**. So please, store it there!
<p>&nbsp;</p>

# Running it when the inevitable happens (General recovery process.)
## It is not that hard to run it. First of all, don't panic. Your installation is not lost. Second, grab your Arch Linux install USB, plug it into your computer and boot to it. Then:
<p>&nbsp;</p>

### 1) List your partitions with `lsblk`
### 2) Create two directories with `mkdir`
* `mkdir /mnt/arch` This will be used for the root partition
* `mkdir /mnt/arch/boot` This will be used for the boot partition
### 3) Mount the root and boot partition to the previously mentioned directories with `mount`. I hope you remember how you set up your Arch Linux installation. Else, I don't know.
* `mount /dev/sdx/sdt /mnt/arch` (Where X is your Linux installation partition, and T is the specific partition where the root account is stored)
* `mount /dev/sdx/sdy /mnt/arch/boot` (Where X is your Linux installation partition, and Y is the specific partition where the boot stuff is stored)
### 4) Chroot into the root directory with `arch-chroot`
* `arch-chroot /mnt/arch`
### 5) Run the script and follow the instructions! ***(Make sure to navigate to the location the script is stored at. Use `cd [location (i.e. /home)]` to navigate somewhere.)***
Run with `sh grubrepairscript.sh`. If there are issues with permissions, run with `sudo` but there shouldn't be any.
<p>&nbsp;</p>

# It didn't fix the issue. What can I do?
## You can inspect the code, take a look at what commands run, and execute them manually. If that fails too, keep trying. If there's an actual error, give me a message, along with the error, and I will try to fix it.
### You can look at the code even if the OS doesn't work. Straight out of the install disk. Just type `nano grubrepairscript.sh` and it should open.
<p>&nbsp;</p>

# **WARNING!**
# In case I lose access to my account or there is a modification to this that I didn't approve of, LOOK AT WHAT COMMANDS RUN! BEWARE OF `sudo rm -rf /` IN PARTICULAR SINCE THAT WILL WIPE YOUR DISK! ALSO CHECK FOR ANY SUSPICIOUS PACKAGES THAT MIGHT BE IN THERE IN THE VERY RARE OCCASION I LOSE ACCESS! PACMAN SHOULD ONLY BE INSTALLING THE LINUX KERNELS!
<p>&nbsp;</p>

### Notes:
This script can also fix the error where GRUB complains about `Invalid magic number`. These steps actually were meant for that error but it also covers this (for me at least).

This error can occur many times. Or so it did for me. You can just follow these instructions whenever it happens.

Fun fact: many other steps can be automated, such as the creation of the directories, the `mount` commands, the chroot, but all those would need the file to be stored at the install disk which is not possible, because the disk doesn't retain any info when its modified other than just the ISO's contents. Maybe the distro's maintainers could do something like including this file if its not considered bloat.

Second fun fact: the first time this occured, it took me 3 hours to fix my installation. So fun.

# License
GNU Public License v3. Check `license.md`
