#!/bin/bash
# Copyright © 2016, William N. Braswell, Jr.. All Rights Reserved. This work is Free \& Open Source; you can redistribute it and/or modify it under the same terms as Perl 5.24.0.
# LAMP Installer Script v0.015_000

# enable extended pattern matching in case statements
shopt -s extglob

# global variables
USER_INPUT=''
CURRENT_SECTION=0

CURRENT_SECTION_COMPLETE () {
    echo
    echo '[[[ SECTION' $CURRENT_SECTION 'COMPLETE ]]]'
    echo
    CURRENT_SECTION=$((CURRENT_SECTION+1))
    while true; do
        read -p "Continue to section $CURRENT_SECTION, yes or no?  [yes] " -n 1 PROMPT_INPUT
        case $PROMPT_INPUT in
            n|N ) echo; echo; exit;;
            y|Y ) echo; echo; break;;
#            ' ' ) echo;;  # NEED FIX: space ' ' should not trigger empty ''
            ''  ) echo; break;;
            *   ) echo;;
        esac
    done
}

C () {  # _C_onfirm user action
    echo $1
    while true; do
        read -p 'Did you do it, yes or no?  [yes] ' -n 1 PROMPT_INPUT
        case $PROMPT_INPUT in
            n|N ) echo; echo; echo $1;;
            y|Y ) echo; echo; break;;
#            ' ' ) echo;;  # NEED FIX: space ' ' should not trigger empty ''
            ''  ) echo; break;;
            *   ) echo;;
        esac
    done
}

P () {  # _P_rompt user for input
    if [ $1 != '__EMPTY__' ]; then
        USER_INPUT=$1
        return
    fi
    while true; do
            read -p "Please type the $2... " USER_INPUT
        case $USER_INPUT in
            [abcdefghijklmnopqrstuvwxyz]+([abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.]) ) echo; break;;
            * ) echo "Please type the $2! "; echo;;
        esac
    done
}

N () {  # prompt user for _N_umeric input
    if [ $1 != '__EMPTY__' ]; then
        USER_INPUT=$1
        return
    fi
    while true; do
            read -p "Please type the $2... " USER_INPUT
        case $USER_INPUT in
            [0123456789]+([0123456789.]) ) echo; break;;
            * ) echo "Please type the $2! "; echo;;
        esac
    done
}

D () {  # prompt user for input w/ _D_efault value
    if [ $1 != '__EMPTY__' ]; then
        USER_INPUT=$1
        return
    fi
    while true; do
            read -p "Please type the $2, or press <ENTER> for $3... " USER_INPUT
        case $USER_INPUT in
            [abcdefghijklmnopqrstuvwxyz]+([abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.]) ) echo; break;;
            '' ) echo; USER_INPUT=$3; break;;
            * ) echo "Please type the $2, or press <ENTER> for $3! "; echo;;
        esac
    done
}

S () {  # _S_udo command
    B sudo $@
}

B () {  # _B_ash command
    COMMAND="       ${02} ${03} ${04} ${05} ${06} ${07} ${08} ${09} ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} \
        ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} ${28} ${29} ${30} ${31} ${32} ${33} ${34} ${35} ${36} ${37} ${38} ${39} \
        ${40} ${41} ${42} ${43} ${44} ${45} ${46} ${47} ${48} ${49} ${50} ${51} ${52} ${53} ${54} ${55} ${56} ${57} ${58} ${59} \
        ${60} ${61} ${62} ${63} ${64} ${65} ${66} ${67} ${68} ${69} ${70} ${71} ${72} ${73} ${74} ${75} ${76} ${77} ${78} ${79} \
        ${80} ${81} ${82} ${83} ${84} ${85} ${86} ${87} ${88} ${89} ${90} ${91} ${92} ${93} ${94} ${95} ${96} ${97} ${98} ${99} "
    if [ $1 = 'sudo' ]; then
        COMMAND_FULL="sudo bash -c ' $COMMAND '"
        PROMPT='Run above command AS ROOT, yes or no?  [yes] '
    else
        COMMAND="$1 $COMMAND"
        COMMAND_FULL="bash -c ' $COMMAND '"
        PROMPT='Run above command, yes or no?  [yes] '
    fi
    echo '$' $COMMAND
    
    while true; do
        read -p "$PROMPT" -n 1 PROMPT_INPUT
        case $PROMPT_INPUT in
            n|N ) echo; echo; return;;
            y|Y ) echo; break;;
            '' ) break;;
            * ) echo;;
        esac
    done

#    $COMMAND_FULL  # ERROR: -c: line 0: unexpected EOF while looking for matching `''
    if [ $1 = 'sudo' ]; then
        sudo bash -c " $COMMAND "
    else
        bash -c " $COMMAND "
    fi
    echo
}

echo  '    [[[<<< LAMP Installer Script >>>]]]'
echo  '          [[[<<< Main Menu >>>]]]'
echo

echo  '        <<< LOCAL CLI SECTIONS >>>'
echo \ '0. [[[        LINUX, CONFIGURE OPERATING SYSTEM USERS ]]]'
echo \ '1. [[[        LINUX, CONFIGURE CLOUD NETWORKING ]]]'
echo \ '2. [[[ UBUNTU LINUX, USB INSTALL, FIX BROKEN SWAP DEVICE ]]]'
echo \ '3. [[[ UBUNTU LINUX, FIX BROKEN LOCALE ]]]'
echo \ '4. [[[ UBUNTU LINUX, INSTALL EXPERIMENTAL UBUNTU SDK BEFORE OTHER PACKAGES ]]]'
echo \ '5. [[[ UBUNTU LINUX, UPGRADE ALL OPERATING SYSTEM PACKAGES ]]]'
echo \ '6. [[[ UBUNTU LINUX, INSTALL BASE CLI OPERATING SYSTEM PACKAGES ]]]'
echo \ '7. [[[ UBUNTU LINUX, INSTALL & TEST CLAMAV ANTI-VIRUS ]]]'
echo \ '8. [[[        LINUX, INSTALL LAMP UNIVERSITY TOOLS ]]]'
echo \ '9. [[[ UBUNTU LINUX, INSTALL HEIRLOOM TOOLS (including bdiff) ]]]'
echo  '10. [[[ UBUNTU LINUX, INSTALL BROADCOM B43 WIFI ]]]'
echo  '11. [[[ UBUNTU LINUX, PERFORMANCE BENCHMARKING ]]]'
echo

echo  '        <<< LOCAL GUI SECTIONS >>>'
echo  '12. [[[ UBUNTU LINUX, INSTALL BASE GUI OPERATING SYSTEM PACKAGES ]]]'
echo  '13. [[[ UBUNTU LINUX, INSTALL EXTRA GUI OPERATING SYSTEM PACKAGES ]]]'
echo  '14. [[[ UBUNTU LINUX, INSTALL XPRA ]]]'
echo  '15. [[[ UBUNTU LINUX, INSTALL VIRTUALBOX GUEST ADDITIONS ]]]'
echo  '16. [[[ UBUNTU LINUX, UNINSTALL OR RECONFIGURE GVFS ]]]'
echo  '17. [[[ UBUNTU LINUX, FIX BROKEN SCREENSAVER ]]]'
echo  '18. [[[ UBUNTU LINUX, CONFIGURE XFCE WINDOW MANAGER ]]]'
echo  '19. [[[ UBUNTU LINUX, ENABLE AUTOMATIC SECURITY UPDATES ]]]'
echo

echo  '         <<< SERVICE SECTIONS >>>'
echo  '20. [[[ UBUNTU LINUX,   INSTALL NFS ]]]'
echo  '21. [[[ UBUNTU LINUX,   INSTALL APACHE & MOD_PERL ]]]'
echo  '22. [[[ APACHE,         CONFIGURE DOMAIN(S) ]]]'
echo  '23. [[[ UBUNTU LINUX,   INSTALL MYSQL & PHPMYADMIN ]]]'
echo  '24. [[[ APACHE & MYSQL, CONFIGURE PHPMYADMIN ]]]'
echo  '25. [[[ UBUNTU LINUX,   INSTALL WEBMIN ]]]'
echo  '26. [[[ UBUNTU LINUX,   INSTALL POSTFIX ]]]'
echo  '27. [[[ UBUNTU LINUX,   INSTALL NON-LATEST PERL CATALYST ]]]'
echo  '28. [[[ UBUNTU LINUX,   INSTALL PERL CPANM & LOCAL::LIB ]]]'
echo  '29. [[[ UBUNTU LINUX,   INSTALL HAND-COMPILED PERL, OR PERLBREW & CPANMINUS ]]]'
echo  '30. [[[ PERL CATALYST,  INSTALL TUTORIAL FROM CPAN ]]]'
echo  '31. [[[ UBUNTU LINUX,   INSTALL PERL CATALYST SHINYCMS PREREQUISITES ]]]'
echo  '32. [[[ PERL CATALYST,  INSTALL SHINYCMS FROM GITHUB & LATEST CATALYST FROM CPAN ]]]'
echo  '33. [[[ PERL CATALYST,  INSTALL RAPIDAPP FROM GITHUB & LATEST CATALYST FROM CPAN ]]]'
echo  '34. [[[ PERL CATALYST,  CHECK VERSIONS ]]]'
echo

while true; do
    read -p 'Please type your chosen main menu section number, or press <ENTER> for 0... ' MENU_CHOICE
    case $MENU_CHOICE in
        [0123456789]|[12][0123456789]|3[01234] ) echo; break;;
        '' ) echo; MENU_CHOICE=0; break;;
        * ) echo 'Please choose a section number from the menu!'; echo;;
    esac
done

CURRENT_SECTION=$MENU_CHOICE

echo  '          [[[<<< Machine Menu >>>]]]'
echo
echo \ '0. [[[      NEW MACHINE; SERVER; REMOTE CLOUD HOST ]]]'
echo \ '1. [[[ EXISTING MACHINE; CLIENT; LOCAL USER SYSTEM ]]]'
echo

while true; do
    read -p 'Please type your machine menu choice number, or press <ENTER> for 0... ' MACHINE_CHOICE
    case $MACHINE_CHOICE in
        [01] ) echo; break;;
        '' ) echo; MACHINE_CHOICE=0; break;;
        * ) echo 'Please choose a number from the menu!'; echo;;
    esac
done

# SECTION 0 VARIABLES
EDITOR='__EMPTY__'
USERNAME='__EMPTY__'
IP_ADDRESS='__EMPTY__'
DOMAIN_NAME='__EMPTY__'

if [ $MENU_CHOICE -le 0 ]; then
    echo '0. [[[ LINUX, CONFIGURE OPERATING SYSTEM USERS ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '0. [[[ NEW MACHINE; SERVER; REMOTE CLOUD HOST ]]]'
        echo '[ Reset root Password ]'
        S passwd  # NEED FIX: disable root account???
        echo '[ Remove Default User ]'
        S userdel user
        S rm -Rf /home/user
        echo '[ Create New User ]'
        P $USERNAME 'new username to be created'
        USERNAME=$USER_INPUT
        S useradd $USERNAME
        S passwd $USERNAME
        S cp -a /etc/skel /home/$USERNAME
        S chown -R $USERNAME.$USERNAME /home/$USERNAME
        S chmod -R go-rwx /home/$USERNAME
        S chsh -s /bin/bash $USERNAME
        echo "[ Manually Add $USERNAME To User Group sudo, Allows Running root Commands (Like update-manager) Via sudo In xpra ]"
        D $EDITOR 'preferred text editor' 'vi'
        EDITOR=$USER_INPUT
        S $EDITOR /etc/group
        echo '[ Take Note Of IP Address For Use On Existing Machine ]'
        B ifconfig
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine Now..."
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo '1. [[[ EXISTING MACHINE; CLIENT; LOCAL USER SYSTEM ]]]'
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine First..."
        P $USERNAME "new machine's username"
        USERNAME=$USER_INPUT
        N $IP_ADDRESS "new machine's IP address (ex: 123.145.167.189)"
        IP_ADDRESS=$USER_INPUT
        P $DOMAIN_NAME "new machine's fully-qualified domain name (ex: domain.com OR subdomain.domain.com)"
        DOMAIN_NAME=$USER_INPUT
        echo '[ Manually Add New Machine IP Address & Domain Name ]'
        echo '[ Copy Data From The Following Line ]'
        echo $IP_ADDRESS $DOMAIN_NAME
        echo
        D $EDITOR 'preferred text editor' 'vi'
        EDITOR=$USER_INPUT
        S $EDITOR /etc/hosts
        echo '[ Enable Passwordless SSH ]'
        echo '[ Do Not Re-Run ssh-keygen If Already Done In The Past ]'
        B ssh-keygen
        B ssh-copy-id $USERNAME@$DOMAIN_NAME
        echo '[ You May Be Prompted Once To Unlock Keyring, Passwordless Thereafter ]'
        B ssh $USERNAME@$DOMAIN_NAME
        B ssh $USERNAME@$DOMAIN_NAME
        echo '[ Copy Run Commands & Config Files To New Machine: bash, vi, git ]'
        B scp ~/.bashrc ~/.vimrc ~/.gitconfig $DOMAIN_NAME:~/
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 1 ]; then
    echo '1. [[[ LINUX, CONFIGURE CLOUD NETWORKING ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine First..."
        S mv /tmp/hosts /etc/hosts
        D $EDITOR 'preferred text editor' 'vi'
        EDITOR=$USER_INPUT
        P $DOMAIN_NAME "new machine's fully-qualified domain name (ex: domain.com OR subdomain.domain.com)"
        DOMAIN_NAME=$USER_INPUT
        echo '[ Manually Modify Hosts File; Update localhost Entry, Disable Public Entry If Present ]'
        echo '[ Example File Content On The Following Lines ]'
        echo "127.0.1.1       $DOMAIN_NAME  # === EDIT THIS LINE TO BE YOUR LOCAL HOSTNAME AKA FULLY-QUALIFIED DOMAIN NAME, AS SHOWN HERE ==="
        echo '# === COMMENT OR REMOVE LOCAL HOSTNAME IF APPEARING BELOW ==='
        echo '...'
        echo '111.222.111.222 foo.com  # ignore this entry'
        echo "#123.123.123.123 $DOMAIN_NAME  # === THIS IS THE ENTRY WHICH NEEDS TO BE DISABLED, AS SHOWN HERE ==="
        echo '100.200.100.200 bar.com  # ignore this entry'
        echo '...'
        echo
        S $EDITOR /etc/hosts
        echo '[ Modify Hostname File ]'
        S "echo $DOMAIN_NAME > /etc/hostname"  # DEV NOTE: must wrap redirects in quotes
        echo '[ Modify Network Interfaces File, Append Google DNS Servers To End Of File ]'
        S 'echo -e "\ndns-nameservers 8.8.8.8 8.8.4.4" >> /etc/network/interfaces'  # DEV NOTE: must wrap redirects in quotes
        echo '[ Reboot, Then Check /etc/resolv.conf File To Confirm The Following Lines Have Been Appended ]'
        echo 'nameserver 8.8.8.8'
        echo 'nameserver 8.8.4.4'
        echo
        S reboot
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        P $DOMAIN_NAME "new machine's fully-qualified domain name (ex: domain.com OR subdomain.domain.com)"
        DOMAIN_NAME=$USER_INPUT
        B scp /etc/hosts $DOMAIN_NAME:/tmp/hosts
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine Now..."
    fi
    CURRENT_SECTION_COMPLETE
fi

# SECTION 2 VARIABLES
SWAP_DEVICE='__EMPTY__'

if [ $MENU_CHOICE -le 2 ]; then
    echo '2. [[[ UBUNTU LINUX, USB INSTALL, FIX BROKEN SWAP DEVICE ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ WARNING: This section only applies to Ubuntu installed from a USB drive! ]'
        C 'Please read the warning above.  Seriously.'
        echo '[ During Installation, Swap May Be Created On /dev/sda5 Device, Determine Device ]'
        B ls -l /dev/sd*
        D $SWAP_DEVICE "new machine's USB installation swap device file" '/dev/sda5'
        SWAP_DEVICE=$USER_INPUT
        echo '[ Copy UUID ]'
        B blkid $SWAP_DEVICE
        echo '[ Manually Update UUID Entries In /etc/fstab And/Or /etc/crypttab Files To Reflect New /dev/sd* Drive Letters ]'
        D $EDITOR 'preferred text editor' 'vi'
        EDITOR=$USER_INPUT
        S $EDITOR /etc/fstab
        S $EDITOR /etc/crypttab
        echo '[ View Current Swap Summary, Turn Current Swap Devices Off, Turn Updated Swap Devices On, View Updated Swap Summary ]'
        S swapon -s
        S swapoff -a
        S swapon -a
        S swapon -s
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
        echo
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 3 ]; then
    echo '3. [[[ UBUNTU LINUX, FIX BROKEN LOCALE ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ Generate & Reconfigure Locales To Fix "perl: warning: Setting locale failed." ]'
        S locale-gen en_US.UTF-8
        S dpkg-reconfigure locales
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 4 ]; then
    echo '4. [[[ UBUNTU LINUX, INSTALL EXPERIMENTAL UBUNTU SDK BEFORE OTHER PACKAGES ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ WARNING: THIS SECTION IS EXPERIMENTAL!  This should NOT be done if you are not sure about what you are doing!!! ]'
        C 'Please read the warning above.  Seriously.'
        S apt-get install ubuntu-sdk
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 5 ]; then
    echo '5. [[[ UBUNTU LINUX, UPGRADE ALL OPERATING SYSTEM PACKAGES ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ WARNING: THIS SECTION IS EXPERIMENTAL!  This should NOT be done if you are not sure about what you are doing!!! ]'
        C 'Please read the warning above.  Seriously.'
        # NEED FIX: gvim AKA vim-gtk3 Has Unmet Dependencies After `apt-get upgrade` In Ubuntu 16.04.1 Xenial
        # https://bugs.launchpad.net/ubuntu/+source/vim/+bug/1613949
        echo '[ Update Package List & Upgrade All Packages ]'
        S apt-get update
        S apt-get upgrade
        echo '[ Check Install, Confirm No Errors, Only Non-Upgraded Packages Allowable ]'
        S apt-get -f install
        echo '[ Review Non-Upgraded (Kept Back) Packages, Confirm Suitability For Safe-Upgrade ]'
        S apt-get upgrade 
        S apt-get install aptitude
        S aptitude safe-upgrade
        echo '[ Check Install, Confirm No Errors & Nothing Remaining To Upgrade ]'
        S apt-get -f install
        S apt-get upgrade
        echo '[ Clean Unneeded Files & Reboot ]'
        S apt-get autoremove
        S reboot
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 6 ]; then
    echo '6. [[[ UBUNTU LINUX, INSTALL BASE CLI OPERATING SYSTEM PACKAGES ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ Check Install, Confirm No Errors ]'
        S apt-get update
        S apt-get -f install
        echo '[ General Tools: g++ ssh perl-doc vim linuxlogo lynx screen ]'
        echo '[ LAMP University Tools Requirements: zip unzip ]'
        echo '[ RPerl Requirements: git curl astyle ]'
        S apt-get install g++ ssh zip unzip perl-doc vim linuxlogo git curl astyle lynx screen
        echo '[ Check Install, Confirm No Errors ]'
        S apt-get -f install
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 7 ]; then
    echo '7. [[[ UBUNTU LINUX, INSTALL & TEST CLAMAV ANTI-VIRUS ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ NOTE: ClamAV should be skipped on low-memory systems. ]'
        C 'Please read the note above.'
        S apt-get install clamav clamav-daemon 
        S freshclam
        S clamscan -r /home
        P $USERNAME "new machine's username"
        USERNAME=$USER_INPUT
        S "cd /home/$USERNAME; wget http://www.eicar.org/download/eicar.com"
        S clamscan -r /home
        S clamscan --infected --remove --recursive /home
        S clamscan -r /home
        S /etc/init.d/clamav-daemon start
        S /etc/init.d/clamav-daemon status
        S /etc/init.d/clamav-freshclam start
        S /etc/init.d/clamav-freshclam status
        S clamdscan -V
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 8 ]; then
    echo '8. [[[        LINUX, INSTALL LAMP UNIVERSITY TOOLS ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        B wget https://github.com/wbraswell/lampuniversity.org/archive/master.zip
        B mv master.zip lampuniversity.org-master.zip
        B unzip lampuniversity.org-master.zip
        B mkdir ~/bin
        B cp lampuniversity.org-master/bin/* ~/bin
        B rm -Rf lampuniversity.org*
        C 'Please log out and log back in, to reset the $PATH environmental variable to include the newly-created /home/bin directory, then come back to this point.'
        echo '[ Test LAMP University Tools, Top Memory Script ]'
        B topmem.sh
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 9 ]; then
    echo '9. [[[ UBUNTU LINUX, INSTALL HEIRLOOM TOOLS ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ NOTE: Only install the Heirloom Tools if you specifically need bdiff or one of the other tools. ]'
        C 'Please read the note above.'
        S apt-get install zlib1g-dev libncurses5-dev libssl-dev
        S wget https://github.com/halcyon/ubuntu-heirloom/archive/master.zip
        S mv master.zip ubuntu-heirloom-master.zip
        S unzip ubuntu-heirloom-master.zip
        S 'cd ubuntu-heirloom-master; ./build.sh'
        S rm -Rf ubuntu-heirloom-master*
        echo '[ Test Heirloom Tools, bdiff Script ]'
        B /usr/5bin/bdiff
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 10 ]; then
    echo '10. [[[ UBUNTU LINUX, INSTALL BROADCOM B43 WIFI ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ WARNING: This section is only for affected machines such as Dell Latitude D430 & D630 ]'
        echo '[ Symptoms include no working wireless support, and the inability to shut down or reboot or suspend. ]'
        C 'Please read the warning above.  Seriously.'
        S apt-get remove bcmwl-kernel-source dkms
        S apt-get install firmware-b43-installer
        S reboot
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 11 ]; then
    echo '11. [[[ UBUNTU LINUX, PERFORMANCE BENCHMARKING ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo "Nothing To Do On Current Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine Now..."
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine Now..."
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 12 ]; then
    echo '12. [[[ UBUNTU LINUX, INSTALL BASE GUI OPERATING SYSTEM PACKAGES ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo "Nothing To Do On Current Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine Now..."
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine Now..."
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 13 ]; then
    echo '13. [[[ UBUNTU LINUX, INSTALL EXTRA GUI OPERATING SYSTEM PACKAGES ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo "Nothing To Do On Current Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine Now..."
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine Now..."
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 14 ]; then
    echo '14. [[[ UBUNTU LINUX, INSTALL XPRA ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo "Nothing To Do On Current Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine Now..."
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine Now..."
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 15 ]; then
    echo '15. [[[ UBUNTU LINUX, INSTALL VIRTUALBOX GUEST ADDITIONS ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo "Nothing To Do On Current Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine Now..."
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine Now..."
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 16 ]; then
    echo '16. [[[ UBUNTU LINUX, UNINSTALL OR RECONFIGURE GVFS ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo "Nothing To Do On Current Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine Now..."
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine Now..."
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 17 ]; then
    echo '17. [[[ UBUNTU LINUX, FIX BROKEN SCREENSAVER ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo "Nothing To Do On Current Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine Now..."
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine Now..."
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 18 ]; then
    echo '18. [[[ UBUNTU LINUX, CONFIGURE XFCE WINDOW MANAGER ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo "Nothing To Do On Current Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine Now..."
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine Now..."
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 19 ]; then
    echo '19. [[[ UBUNTU LINUX, ENABLE AUTOMATIC SECURITY UPDATES ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo "Nothing To Do On Current Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine Now..."
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine Now..."
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 20 ]; then
    echo '20. [[[ UBUNTU LINUX, INSTALL NFS ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo "Nothing To Do On Current Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On Existing Machine Now..."
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine First..."
        C "Please Run LAMP Installer Section $CURRENT_SECTION On New Machine Now..."
    fi
    CURRENT_SECTION_COMPLETE
fi