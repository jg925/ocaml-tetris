# Install directions for MS1

## Windows instructions

For installing the Graphics package:

1. Run `sudo apt install pkg-config`

2. Run `opam install graphics`

For installing and running Xming:

1. Download and install the [Xming X Server][https://sourceforge.net/projects/xming/]

2. Run XLaunch and don't change any of the default settings, specifically
  - Select "Multiple windows"
  - Display number is 0
  - Select "Start no client"
  - Select "Clipboard"

3. In terminal, enter `export DISPLAY=:0`, making sure not to have spaces around the equals