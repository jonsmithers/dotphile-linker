Dotphile
===========

Yet another dotfile installer. Dotphile's siblings include [DotBot](https://github.com/anishathalye/dotbot), [rcm](https://github.com/thoughtbot/rcm), and [holman dotfiles](https://github.com/holman/dotfiles). This one tries to be simple, adoptable, and trustworthy.

### To start using Dotphile

###### First-time steps

1. Create a directory (say, `~/.dotfiles`)
2. Place the script in said directory
3. Run the script once to generate a starting config file

###### For each dotfile

1. Move a dotfile (say, `~/.bash_profile`) to your dotfiles directory
2. Add this line inside the config file: `./.bash_profile : ~/.bash_profile`
3. Run the script to symlink it back to `~/.bash_profile`
4. (Repeat for as many dotfiles as you like)

### Config script

Dotphile uses a JSON configuration file. It might look something like this:

```JSON
{
  "links": {
    "./.bash_profile" : "~/.bash_profile",
    "./.gitconfig"    : "~/.gitconfig",
    "./.vimrc"        : "~/.vimrc"
  }
}
```

