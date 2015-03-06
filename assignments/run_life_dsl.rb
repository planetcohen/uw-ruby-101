# script for running Game of Life in a Tk Canvas, where the game is created from a DSL

load 'final_project.rb'

BOARD_SIZE = 10
DELAY_IN_MILLIS = 2000

s = FinalProject::TkRenderStrategy.new(BOARD_SIZE)
g = gol BOARD_SIZE, s, '
.***.
*...****
*...*
*...****
.***.
'

my_timer = TkTimer.new(DELAY_IN_MILLIS, -1, proc {g.render; g.evolve})
my_timer.start

Tk.mainloop
