LINKTYPE = -s # -s for soft, or -P for hard
DOTFILES = .bash_aliases .gitignore .vimrc .XCompose .xkb # List of dotfiles
all: link
	# Needed so that xkb settings not overwritten by gnome
	gsettings set org.gnome.settings-daemon.plugins.keyboard active false
	git config --global core.excludesfile ~/.gitignore # Set up global gitignore
	crontab crontab # Load crontab settings from file

.PHONY: link $(DOTFILES) # Not a real file target
link: $(DOTFILES) # To make link, process dotfiles
$(DOTFILES): # To operate on dotfiles, process these commands
	ln $(LINKTYPE) ~/dotfiles/$@ ~/$@ # Link them (Specify soft or hard in LINKTYPE)
