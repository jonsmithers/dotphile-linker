Dotphile
===========

Yet another dotfile installer. Dotphile's siblings include
[DotBot](https://github.com/anishathalye/dotbot),
[rcm](https://github.com/thoughtbot/rcm), and [holman
dotfiles](https://github.com/holman/dotfiles). This one tries to be simple,
adoptable, and trustworthy.

### To start using Dotphile

###### First-time steps

1. Create a directory (say, `~/.dotfiles`)
2. Place the script in said directory
3. Run the script once to generate a starting config file

###### For each dotfile

1. Move a dotfile (say, `~/.bashrc`) to your dotfiles directory
2. Add this line inside the config file: `./.bashrc : ~/.bashrc`
3. Run the script to symlink it back to `~/.bashrc`
4. (Repeat for as many dotfiles as you like)

### Config script

Dotphile uses a JSON configuration file. It might look something like this:

```JSON
{
  "links": {
    "./.bashrc":    "~/.bashrc",
    "./.gitconfig": "~/.gitconfig",
    "./.vimrc":     "~/.vimrc"
  }
}
```
