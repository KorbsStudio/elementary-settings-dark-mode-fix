#!/bin/sh

# Auth
  while ! zenity --password  --ok-label="Continue"| sudo -S cat /dev/null >/dev/null; do
    if $(zenity --question --ellipsize --text="Wrong password, would you like to cancel the installation?"); then
      echo "no app-entry made, returning"
      zenity --warning --ellipsize --text="The installation was interrupted."
      return;
    fi
  done

(
echo "10" ;
echo "# Creating new directory" ;
  sudo mkdir /usr/share/korbs-studio/
  cd /usr/share/korbs-studio
echo "20" ;
echo "# Downloading scripts" ;
  sudo wget "https://raw.githubusercontent.com/KorbsStudio/elementary-settings-dark-mode-fix/master/sh-files/settings-dark-mode.sh"
  sudo wget "https://raw.githubusercontent.com/KorbsStudio/elementary-settings-dark-mode-fix/master/sh-files/wingpanel-dark-mode.sh"
echo "30" ;
echo "# Backing up .desktop files" ;
  sudo cp /usr/share/applications/io.elementary.switchboard.desktop /usr/share/korbs-studio/
  sudo cp /usr/share/applications/io.elementary.wingpanel.desktop /usr/share/korbs-studio/
echo "40" ;
echo "# Deleting original .desktop files" ;
  cd /usr/share/applications/
  sudo rm io.elementary.switchboard.desktop # This is back up first before deleting it
  sudo rm io.elementary.wingpanel.desktop # This is back up first before deleting it
echo "75" ;
echo "# Downloading new .desktop files" ;
  sudo wget "https://raw.githubusercontent.com/KorbsStudio/elementary-settings-dark-mode-fix/master/desktop-files/io.elementary.switchboard.desktop"
  sudo wget "https://raw.githubusercontent.com/KorbsStudio/elementary-settings-dark-mode-fix/master/desktop-files/io.elementary.wingpanel.desktop"
echo "87" ;
echo "# Adding new startup script" ;
  cd ~/.config/autostart/
  sudo wget "https://raw.githubusercontent.com/KorbsStudio/elementary-settings-dark-mode-fix/master/desktop-files/dark-mode-wingpanel-startup.desktop" # Wingpanel doesn't use it's desktop file on start, autorun script must be used
echo "# Done" ;
echo "100" ;
) |
zenity --progress \
  --title="Dark Variant Fix" \
  --text="Dark Variant Fix" \
  --percentage=0

if [ "$?" = -1 ] ; then
        zenity --error \
          --text="Installation cancelled" --ellipsize
fi

if zenity --question --icon-name=system-restart --text="Restart for wingpanel to switch to dark mode?" --ellipsize
  then 
      (
        echo "# Rebooting..." ;
        echo "0" ; sleep 1
        echo "25" ; sleep 1
        echo "50" ; sleep 1
        echo "75" ; sleep 1
        echo "100" ;
        reboot
      ) |
      zenity --progress \
        --title="Rebooting..." \
        --text="Rebooting..." \
        --percentage=0

      if [ "$?" = -1 ] ; then
        zenity --error \
        zenity --info --text="Restart required for wingpanel" --icon-name="object-inverse" --ellipsize
      fi
fi