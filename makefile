LINKTYPE = -s # -s for soft, or -P for hard
DOTFILES = .bash_aliases .gitignore .vimrc .XCompose .Xmodmap # List of dotfiles
all: link
	git config --global core.excludesfile ~/.gitignore # Set up global gitignore

.PHONY: link $(DOTFILES) # Not a real file target
link: $(DOTFILES) # To make link, process dotfiles
$(DOTFILES): # To operate on dotfiles, process these commands
	ln $(LINKTYPE) ~/dotfiles/$@ ~/$@ # Link them (Specify soft or hard in LINKTYPE)
