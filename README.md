# Hitori Solver with CLIPS

Hitori is a logic puzzle popularized by [Nikoli](https://www.nikoli.co.jp/en/). Hitori is played with a grid of squares or cells, with each cell initially containing a number. The game is played by eliminating squares/numbers and this is done by blacking them out. The objective is to transform the grid to a state wherein all three following rules are true:

- no row or column can have more than one occurrence of any given number
- black cells cannot be adjacent, although they can be diagonal to one another.
- the remaining numbered cells must be all connected to each other, horizontally or vertically.

Some of the specific rules and techniques implemented were found here:

http://tectonicpuzzel.eu/hitori-solving-techniques.html

https://www.conceptispuzzles.com/index.aspx?uri=puzzle/hitori/techniques
