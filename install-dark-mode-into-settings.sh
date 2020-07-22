#!/bin/sh

# Auth
  while ! zenity --password  --ok-label="Continue"| sudo -S cat /dev/null >/dev/null; do
    if $(zenity --question --icon-name="preferences-desktop" --ellipsize --text="Wrong password, would you like to cancel the installation?"); then
      echo "no app-entry made, returning"
      zenity --warning --ellipsize --text="The installation was interrupted."
      return;
    fi
  done
    echo "$appEntry" | sudo -S tee ${launcher}
    (
        sudo mkdir /usr/share/korbs-studio/
        cd /usr/share/korbs-studio
        sudo wget "https://raw.githubusercontent.com/KorbsStudio/elementary-settings-dark-mode-fix/master/settings-dark-mode.sh"

        echo "# Backing up io.elementary.switchboard.desktop to /usr/share/korbs-studio/"
        sudo cp /usr/share/applications/io.elementary.switchboard.desktop /usr/share/korbs-studio/

        echo "# Updating io.elementary.switchboard.desktop"
        cd /usr/share/applications/
        sudo rm io.elementary.switchboard.desktop # This is back up first before deleting it
        sudo wget "https://raw.githubusercontent.com/KorbsStudio/elementary-settings-dark-mode-fix/master/io.elementary.switchboard.desktops"

    ) |
zenity --progress --title "GUI Installer" \
--width 500 --text "Installing..." --percentage=0
clear
zenity --info --pulsate --ellipsize --icon-name="preferences-desktop" --title="Job completed" --text="Dark Mode fixed on Settings"
sudo -K
clear
