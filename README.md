DotPhile
===========

Yet another dotfile installer. This one tries to be real simple and trustworthy.

### To start using DotPhile

1. Create a directory (say, `~/.dotfiles`). 
2. Place the ruby script in said directory.
3. Run the script once to generate a starting config file.
4. Move a dotfile (say, `~/.bash_profile`) to said directory.
5. Add this line inside the config file: `./.bash_profile : ~/.bash_profile`
6. Run the script to symlink it back to `~/.bash_profile`
7. Repeat for as many dotfiles as you like.


