# Summary

This is my setup for the hydra window manager:

https://github.com/sdegutis/hydra

As usual, the keybindings are located in init.lua.

The application-specific configuration is located in config.lua.

# Installation

1. Clone this repository into $HOME/.hydra on your system.
    - Can be accomplished by running `make install`
2. Copy config.lua.example to config.lua
3. Modify config.lua to meet your needs
4. Copy init.lua.example to init.lua
5. Modify init.lua to meet your needs

NOTE: Running `make all` (or just `make`) will copy the example configs to a usable name.

To completely setup and get going, you can run:

```
$ make all
$ make install
```
