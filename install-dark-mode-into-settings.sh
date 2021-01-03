#!/bin/sh

# Auth
  while ! zenity --password  --ok-label="Continue"| sudo -S cat /dev/null >/dev/null; do
    if $(zenity --question --icon-name="preferences-desktop" --ellipsize --text="Wrong password, would you like to cancel the installation?"); then
      echo "no app-entry made, returning"
      zenity --warning --ellipsize --text="The installation was interrupted."
      return;
    fi
  done


        echo "Fixing dark mode for System Settings and Wingpanel"
        sleep 1;
        sudo mkdir /usr/share/korbs-studio/
        cd /usr/share/korbs-studio
        sudo wget "https://raw.githubusercontent.com/KorbsStudio/elementary-settings-dark-mode-fix/master/settings-dark-mode.sh"
        sudo wget "https://raw.githubusercontent.com/KorbsStudio/elementary-settings-dark-mode-fix/master/wingpanel-dark-mode.sh"

        echo "# Backing up io.elementary.switchboard.desktop to /usr/share/korbs-studio/"
        sudo cp /usr/share/applications/io.elementary.switchboard.desktop /usr/share/korbs-studio/
        sudo cp /usr/share/applications/io.elementary.wingpanel.desktop /usr/share/korbs-studio/

        echo "# Updating io.elementary.switchboard.desktop"
        cd /usr/share/applications/
        sudo rm io.elementary.switchboard.desktop # This is back up first before deleting it
        sudo rm io.elementary.wingpanel.desktop # This is back up first before deleting it
        sudo wget "https://raw.githubusercontent.com/KorbsStudio/elementary-settings-dark-mode-fix/master/io.elementary.switchboard.desktop"
        sudo wget "https://raw.githubusercontent.com/KorbsStudio/elementary-settings-dark-mode-fix/master/io.elementary.wingpanel.desktop"
        sudo mv io.elementary.switchboard.desktops io.elementary.switchboard.desktop


sudo -K
zenity --warning --text="Restart device to get dark mode on the wingpanel" --ellipsize
clear
