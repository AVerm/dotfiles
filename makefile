LINKTYPE = -s # -s for soft, or -P for hard
DOTFILES = .bash_aliases .gitignore .vimrc .XCompose .xkb # List of dotfiles
CRONFILE = crontab # Location of file holding crontab contents
all: link git cron keyboardsettings # These are the three main tagets

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
keyboardsettings: # To set up keyboard for gnome
	gsettings set org.gnome.settings-daemon.plugins.keyboard active false # Needed so that xkb settings not overwritten by gnome
