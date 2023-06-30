LINKTYPE = -s # -s for soft, or -P for hard
DOTFILES = .bash_aliases .gitignore .inputrc .vimrc .XCompose .screenrc project.screenrc dashboard.screenrc scripts .ghci .dmrc # List of dotfiles
CRONFILE = .crontab # Location of file holding crontab contents
XKB_DIR = /usr/share/X11/
all: link git cron keyboardsettings userchrome # These are the top-level tagets

.PHONY: link $(DOTFILES) # Not a real file target
link: $(DOTFILES) # To make link, process dotfiles
$(DOTFILES): # To operate on dotfiles, process these commands
	ln $(LINKTYPE) ~/dotfiles/$@ ~/$@ # Link them (Specify soft or hard in LINKTYPE)

.PHONY: git # Not a real file target
git: # To set up git, run this command
	touch ~/.gitignore # Create global gitignore if nonexistent
	git config --global core.excludesfile ~/.gitignore # Set up global gitignore

.PHONY: cron # Not a real file target
cron: $(CRONFILE) # To set up crontab, run this command
	crontab $(CRONFILE) # Load crontab settings from file

.PHONY: keyboardsettings # Not a real file target
keyboardsettings: .xkb # To set up keyboard for gnome
	sudo rm -rf /usr/share/X11/xkb/my_configuration
	sudo ln $(LINKTYPE) ~/dotfiles/.xkb/symbols/my_configuration /usr/share/X11/xkb
	#ln $(LINKTYPE) ~/dotfiles/.xkb/keymap /usr/share/X11/
	gsettings set org.gnome.settings-daemon.plugins.keyboard active false # Needed so that xkb settings not overwritten by gnome

userchrome:
	echo "Don't forget to set up your userChrome.css!"
