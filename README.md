# Anton's dotfiles

## Setup
#### installing & using

* clone that repo
* read and run parts of `setup-a-new-machine.sh`
* read and run `symlink-setup.sh`
  * git config needs attention, read the notes.

### The "readline config" (`.inputrc`)
Basically it makes typing into the prompt amazing.

* tab like crazy for autocompletion that doesnt suck. tab all the things. srsly.
* no more <tab><tab> that says "Display all 1745 possibilities? (y or n)" YAY
* type `cat <uparrow>` to see your previous `cat`s and use them.
* case insensitivity.
* tab all the livelong day.


### Moving around in folders (`z`, `...`, `cdf`)
`z` helps you jump around to whatever folder. It uses actual real magic to determine where you should jump to. Seperately there's some `...` aliases to shorten `cd ../..` and `..`, `....` etc. Then, if you have a folder open in Finder, `cdf` will bring you to it.
```sh
z dotfiles
z blog
....      # drop back equivalent to cd ../../..
z public
cdf       # cd to whatever's up in Finder
```
`z` learns only once its installed so you'll have to cd around for a bit to get it taught.
Lastly, I use `open .` to open Finder from this path. (That's just available normally.)



## overview of files

####  Automatic config
* `.vimrc`, `.vim` - vim config, obv.
* `.inputrc` - behavior of the actual prompt line

#### shell environment
* `.aliases`
* `.bash_profile`
* `.bash_prompt`
* `.bashrc`
* `.exports`
* `.functions`
* `.extra` - not included, explained below

#### manual run
* `setup-a-new-machine.sh` - random apps i need installed
* `symlink-setup.sh`  - sets up symlinks for all dotfiles and vim config.
* `.osx` - run on a fresh osx setup
* `brew.sh` & `brew-cask.sh` - homebrew initialization

#### git, brah
* `.git`
* `.gitattributes`
* `.gitconfig`
* `.gitignore`


### `.extra` for your private configuration

There will be items that don't belong to be committed to a git repo, because either 1) it shoudn't be the same across your machines or 2) it shouldn't be in a git repo. Kick it off like this:

`touch ~/.extra && $EDITOR $_`

I have some EXPORTS, my PATH construction, and a few aliases for ssh'ing into my servers in there.

I don't know how other folks manage their $PATH, but this is how I do mine:

```shell
# The top-most paths override here.
      PATH=/opt/local/bin
PATH=$PATH:/opt/local/sbin
PATH=$PATH:/bin
PATH=$PATH:~/.rvm/bin
PATH=$PATH:~/code/git-friendly
# ...

export PATH
```


### Sensible OS X defaults

Mathias's repo is the canonical for this, but you should probably run his or mine after reviewing it.

```bash
./.osx
```

