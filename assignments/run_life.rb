# script for running Game of Life in a Tk Canvas

load 'final_project.rb'

BOARD_SIZE = 20
DELAY_IN_MILLIS = 100

s = FinalProject::TkRenderStrategy.new(BOARD_SIZE)
g = FinalProject::GameOfLife.new(BOARD_SIZE, s)

my_timer = TkTimer.new(DELAY_IN_MILLIS, -1, proc {g.render; g.evolve})
my_timer.start

Tk.mainloop
