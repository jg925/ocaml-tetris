# Install directions for MS1

## Windows instructions

To install the Graphics package:

1. Run `sudo apt install pkg-config`

2. Run `opam install graphics`

For installing and running Xming:

1. Download and install the [Xming X Server](https://sourceforge.net/projects/xming/)

2. Run XLaunch and don't change any of the default settings, specifically
  - Select "Multiple windows"
  - Display number is 0
  - Select "Start no client"
  - Select "Clipboard"

3. In terminal, enter `export DISPLAY=:0`, making sure not to have spaces around the equals

## Mac instructions

To install the Graphics package:

1. Run `opam install graphics` in terminal, and install any missing dependencies.

2. Choose one of the following display methods.
  - Download [XQuartz](https://www.xquartz.org/) and run Tetris in xterm or terminal with the command below.
  - Update `~/.bashrc` in the Mac terminal with the line `if [ -z $DISPLAY ]; then export DISPLAY=:0.0; fi` and make sure to run `source ~/.bashrc` afterwards. 

# Instructions to run Tetris

1. If on Windows follow the above instructions to start an Xming window and set the export display

2. In terminal navigate to the directory with the project and run `make` to launch Tetris.

3. When you want to close, do not "x out" of the window, instead do a keyboard interrupt and then run `#quit;;` in utop which will quit the program cleanly.
