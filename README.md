This should fix dark mode for elementary's System Settings.
Open your terminal and type in the following and a setup should appear.
```
bash <(wget -qO- https://raw.githubusercontent.com/KorbsStudio/elementary-settings-dark-mode-fix/master/install-dark-mode-into-settings.sh)
```
Don't worry, the file that opens your system settings will be back up to `/usr/share/korbs-studio/` if something breaks.

## Fixing Dark Mode for Wingpanel(Top panel)
Since elementary OS doesn't automatically start Wingpanel from `/usr/share/applications/`, from the looks of it that is, you'll need to add a command to startup.
So when elementary OS starts, it runs a command to kill the process of wingpanel and then starts wingpanel with dark mode by using `GTK_THEME` command this time.
Go to Applications in System Settings, then click on the Startup tab. Click the add button and use a custom command:
```
sh /usr/share/korbs-studio/wingpanel-dark-mode.sh
```

This repo will be archived when [elementary OS 6.0](https://blog.elementary.io/dark-style-progress/) is released, as the new major update includes dark mode with the new stylesheet includes.

### To Do List
- [x] Fix dark mode for wingpanel
- [ ] Fix dark mode for File Manager when it runs as admin
- [ ] Fix dark mode for 
