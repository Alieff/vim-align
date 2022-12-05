# Feature
This vim plugin enable you to align text easily

#### Demo
![Demo](docs/demo.gif)

# Installation
## Pathogen

Clone this repo to your plugin folder (usually in $HOME/.vim/bundle/)


## Usage : 

#### Single Line
1. mark a position, using character 'k' (ex: `mk`)
2. move cursor to a position
3. `:Align`
4. character from current position will be shifted up to mark 'k' position (column wise)

#### Multi Line
1. mark a position, using character 'k' (ex: `mk`)
2. block-visual-select a path
3. `:Align`
4. characters (each line) from current position (column) will be shifted up to mark 'k' position (column wise)
