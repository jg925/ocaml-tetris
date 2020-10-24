# Install directions for MS1

## Windows instructions

For installing the Graphics package:

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


# Instructions to run Tetris

1. If on Windows follow the above instructions to start an Xming window and set the export display

2. In terminal navigate to the directory with the project and run `make build`

3. Run `utop`

4. Run `#load "tile.cmo";;`

5. Run `#load "board.cmo";;`

6. Run `#load "main.cmo";;`

5. Run `Main.start ();;` and a window should pop up with the basic game board drawn

6. When you want to close, do not "x out" of the window, instead run `#quit;;` in utop which will quit the program cleanly.