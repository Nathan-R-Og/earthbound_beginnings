# Earthbound Beginnings

WIP port using [Replatform64](https://github.com/Herringway/replatform64), a console game porting framework.

See also: [The Disassembly](https://github.com/Nathan-R-Og/mother).

## Supported Hashes

| Game Version                       | MD5                              |
|------------------------------------|----------------------------------|
| Earthbound Beginnings (Proto) (US) (NES 2.0)|`54387b6e68142d69083a38b437196450`|
| Earthbound Beginnings (Proto) (US) (iNES)   |`5bacf7ba94c539a1caf623dbe12059a3`|

## Installation Guide

0. This project ONLY works on Windows! Replatform64 still has specific issues running on Linux, even as a cross compiler. You have been warned.

1. Get and install [DMD](https://dlang.org/download.html), the D Compiler. I'm sure any works, but I chose DMD specifically.

2. Get and install [Python](https://www.python.org/downloads/windows/).

3. Snag a Windows [SDL3.dll](https://github.com/libsdl-org/SDL/releases) from the SDL releases page. Just drop it in the root of the project.

4. You must use GraphicsGale in order to edit images. I'm not sure why this is a limitation, but it is. Something about GLDPNG. lol

5. Have a EBB rom. Legally required. Etc.

## Setup guide

1. Place an Earthbound Beginnings rom in the root of your project. Name it `ebb.nes`.
2. Run `python3 ./tools/configure.py`.

## Building guide

1. Run `dub build` to ensure building works.
2. Run `dub run` to build + run straight away.

That's it! :)
