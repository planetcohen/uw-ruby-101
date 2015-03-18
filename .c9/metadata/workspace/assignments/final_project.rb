{"changed":true,"filter":false,"title":"final_project.rb","tooltip":"/assignments/final_project.rb","value":"# ========================================================================================\n#  Final Project: Game of Life\n# ========================================================================================\n\n#  The Game of Life is a simplified model of evolution and natural selection\n#  invented by the mathematician James Conway.\n\n#  http://en.wikipedia.org/wiki/Conway's_Game_of_Life\n\n\n#  ---------------------------------------------------------------------------------------\n#  Rules\n\n#  You have a grid of cells in 2 dimensions.\n\n#  Each cell has 8 neighbors:\n#  - top, right, bottom, left\n#  - top-left, top-right, bottom-right, bottom-left\n\n#  Each cell has 2 possible states: alive or dead.\n\n#  if a cell is alive and\n#  - has fewer than 2 live neighbors, it dies \n#  - has more than 3 live neighbors, it dies\n#  - has 2 or 3 live neighbors, it lives to next generation\n\n#  if cell is dead and\n#  - has exactly 3 live neighbors, it becomes a live cell\n\n#  edges of board:\n#  - pretend the board is folded onto itself\n#  - the edges touch each other\n\n\n#  ---------------------------------------------------------------------------------------\n#  Tests\n\n#  You must have MiniTest unit tests for your class to validate your implementation.\n#  You might need to add methods or change the method signatures to enable testing.\n\n\n#  ---------------------------------------------------------------------------------------\n#  Rendering\n\n#  You choose how you want to render the current state of the board.\n#  ASCII? HTML? Something else?\n\n\n#  ---------------------------------------------------------------------------------------\n#  Bonus: DSL\n\n#  - Create a DSL that represents a state of the game.\n#  - Your render method can then be formatted as the DSL, so that you can round-trip\n#    between the textual DSL representation and the running instance.\n\n\n#  ---------------------------------------------------------------------------------------\n#  Suggested Implementation\n\nmodule FinalProject\n  class GameOfLife\n    attr :grid\n    def initialize(size, p)\n      # randomly initialize the board\n      @grid = Array.new(size)\n      @grid.each_with_index {|x, i| @grid[i] = Array.new(size) }\n      seed_grid(p)\n      @iteration = 1\n    end\n    \n    def grid_size\n      @grid.length\n    end\n    \n    def seed_grid(p)\n    # give each cell a (p * 100) percent chance to start the game as a live cell\n      @grid.each_with_index do |x, i|\n        x.each_with_index { |y,j| rand>(1.0-p) ? (@grid[i][j]='X') : (@grid[i][j]=nil) }\n      end\n    end\n    \n    def reseed_block\n      # reseeds a grid with a 2x2 block of live cells.  assumes a grid size >=3.\n      @grid.each_with_index do |x,i|\n        x.each_with_index do |y,j|\n          if (i==1 and j==1) or (i==1 and j==2) then\n            @grid[i][j]='X'\n          elsif (i==2 and j==1) or (i==2 and j==2) then\n            @grid[i][j] = 'X'\n          else\n            @grid[i][j] = nil\n          end\n        end\n      end\n    end\n  \n    def reseed_blinker\n      # reseeds a grid with a 3x1 block of live cells.  assumes a grid size >=5.\n      @grid.each_with_index do |x,i|\n        x.each_with_index do |y,j|\n          if (i==2 and j==1) or (i==2 and j==2) or (i==2 and j==3) then\n            @grid[i][j]='X'\n          else\n            @grid[i][j] = nil\n          end\n        end\n      end\n    end  \n    \n\n    def reseed_glider\n      # reseeds a grid with a \"glider\" block of live cells.  assumes a grid size >=15.\n      @grid.each_with_index do |x,i|\n        x.each_with_index do |y,j|\n          if (i==2 and j==1) or (i==2 and j==2) or (i==2 and j==3) then\n            @grid[i][j]='X'\n          elsif (i==1 and j==3) or (i==0 and j==2)then\n            @grid[i][j]='X'\n          else\n            @grid[i][j] = nil\n          end\n        end\n      end\n    end      \n    \n    def neighbor_coordinates_array(i)\n      out_array = []\n      array_length = @grid.length\n      if i >= (array_length - 1) then\n        out_array = [i-1, i, -1]\n      else\n        out_array = [i-1, i, i+1]\n      end\n      out_array\n    end\n    \n\n    def count_neighbors(x,y)\n      # count the number of neighbors for a given live cell, not counting the cell itself as a neighbor.\n      neighbor_count = 0\n      x_coords = neighbor_coordinates_array(x)\n      y_coords = neighbor_coordinates_array(y)\n      x_coords.each do |i| \n        y_coords.each do |j|\n          neighbor_count += 1 if @grid[i][j]=='X' and !(i==x and y==j)\n        end\n      end\n      neighbor_count\n    end  \n    \n    def evolve\n      # apply rules to each cell and generate new state\n      next_grid = Array.new(@grid.length)\n      next_grid.each_with_index {|x,i| next_grid[i] = Array.new(@grid.length)}\n      @grid.each_with_index do |row,i|\n        row.each_with_index do |cell,j|\n          n_count = count_neighbors(i,j)\n          if (n_count<2 && cell) then\n            next_grid[i][j] = nil\n          elsif (n_count<=3 && cell) then\n            next_grid[i][j] = \"X\"\n          elsif (n_count>3 && cell) then\n            next_grid[i][j] = nil\n          elsif n_count==3 then #assume the cell is not live, since we're here in the IF \n            next_grid[i][j] = \"X\"\n          else\n            next_grid[i][j] = nil\n          end\n        end\n      end \n      @grid = next_grid\n      @iteration += 1\n      nil\n    end\n    \n    def render\n      # render the current state of the board\n      puts '----' * @grid.length;\n      @grid.each do |col|\n        c = []\n        col.each_with_index {|val,i| !val ? c[i]=' ' : c[i]=val }\n        puts c.join(' | ')\n        puts '----' * @grid.length;\n      end\n      nil\n    end\n    \n    def run(num_generations)\n      # evolve and render for num_generations\n      #puts \"generation #{@iteration}:\"\n      #render\n      num_generations.times do \n         evolve\n         puts \"generation #{@iteration}:\"\n         render\n         2.times {puts \"\"}\n         sleep(0.5)\n      end\n    end\n  end\n  \n  g = GameOfLife.new(15,0.4)\n  g.reseed_glider\n  g.render\n  g.evolve\n  g.render\n  \n  g.run(5)\n  \n  require 'minitest/autorun'\n  class TestFinalProject < MiniTest::Test\n    \n    def setup\n      @g = GameOfLife.new(3,0.1)\n    end\n    \n    def test_grid_size\n      assert_equal 3, @g.grid_size\n    end\n    \n    \n  end\n  \nend\n","undoManager":{"mark":87,"position":100,"stack":[[{"group":"doc","deltas":[{"start":{"row":162,"column":20},"end":{"row":162,"column":21},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":21},"end":{"row":162,"column":22},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":22},"end":{"row":162,"column":23},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":23},"end":{"row":162,"column":24},"action":"insert","lines":["="]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":24},"end":{"row":162,"column":25},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":25},"end":{"row":162,"column":26},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":25},"end":{"row":162,"column":26},"action":"remove","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":24},"end":{"row":162,"column":25},"action":"remove","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":24},"end":{"row":162,"column":25},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":25},"end":{"row":162,"column":26},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":25},"end":{"row":162,"column":26},"action":"remove","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":25},"end":{"row":162,"column":26},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":26},"end":{"row":162,"column":27},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":27},"end":{"row":162,"column":28},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":29},"end":{"row":163,"column":0},"action":"insert","lines":["",""]},{"start":{"row":163,"column":0},"end":{"row":163,"column":12},"action":"insert","lines":["            "]}]}],[{"group":"doc","deltas":[{"start":{"row":163,"column":10},"end":{"row":163,"column":12},"action":"remove","lines":["  "]}]}],[{"group":"doc","deltas":[{"start":{"row":163,"column":10},"end":{"row":163,"column":11},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":163,"column":11},"end":{"row":163,"column":12},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":163,"column":12},"end":{"row":163,"column":13},"action":"insert","lines":["d"]}]}],[{"group":"doc","deltas":[{"start":{"row":158,"column":10},"end":{"row":158,"column":11},"action":"remove","lines":["#"]}]}],[{"group":"doc","deltas":[{"start":{"row":158,"column":17},"end":{"row":158,"column":18},"action":"insert","lines":["("]}]}],[{"group":"doc","deltas":[{"start":{"row":158,"column":37},"end":{"row":158,"column":38},"action":"insert","lines":[")"]}]}],[{"group":"doc","deltas":[{"start":{"row":158,"column":41},"end":{"row":158,"column":42},"action":"insert","lines":["("]}]}],[{"group":"doc","deltas":[{"start":{"row":158,"column":57},"end":{"row":158,"column":58},"action":"insert","lines":[")"]}]}],[{"group":"doc","deltas":[{"start":{"row":158,"column":58},"end":{"row":163,"column":13},"action":"remove","lines":["","          if cell then","            puts \"cell = #{cell}\"","          else","            puts \"cell = nil\"","          end"]}]}],[{"group":"doc","deltas":[{"start":{"row":77,"column":49},"end":{"row":77,"column":50},"action":"insert","lines":["("]}]}],[{"group":"doc","deltas":[{"start":{"row":77,"column":65},"end":{"row":77,"column":66},"action":"insert","lines":[")"]}]}],[{"group":"doc","deltas":[{"start":{"row":77,"column":69},"end":{"row":77,"column":70},"action":"insert","lines":["("]}]}],[{"group":"doc","deltas":[{"start":{"row":77,"column":85},"end":{"row":77,"column":86},"action":"insert","lines":[")"]}]}],[{"group":"doc","deltas":[{"start":{"row":159,"column":35},"end":{"row":160,"column":0},"action":"insert","lines":["",""]},{"start":{"row":160,"column":0},"end":{"row":160,"column":12},"action":"insert","lines":["            "]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":12},"end":{"row":160,"column":13},"action":"insert","lines":["p"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":13},"end":{"row":160,"column":14},"action":"insert","lines":["u"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":14},"end":{"row":160,"column":15},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":15},"end":{"row":160,"column":16},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":16},"end":{"row":160,"column":17},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":17},"end":{"row":160,"column":19},"action":"insert","lines":["\"\""]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":18},"end":{"row":160,"column":19},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":19},"end":{"row":160,"column":20},"action":"insert","lines":["_"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":20},"end":{"row":160,"column":21},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":21},"end":{"row":160,"column":22},"action":"insert","lines":["o"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":22},"end":{"row":160,"column":23},"action":"insert","lines":["u"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":23},"end":{"row":160,"column":24},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":24},"end":{"row":160,"column":25},"action":"insert","lines":["t"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":25},"end":{"row":160,"column":26},"action":"insert","lines":["<"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":26},"end":{"row":160,"column":27},"action":"insert","lines":["2"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":27},"end":{"row":160,"column":28},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":28},"end":{"row":160,"column":29},"action":"insert","lines":["&"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":29},"end":{"row":160,"column":30},"action":"insert","lines":[" "]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":30},"end":{"row":160,"column":31},"action":"insert","lines":["c"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":31},"end":{"row":160,"column":32},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":32},"end":{"row":160,"column":33},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":33},"end":{"row":160,"column":34},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":159,"column":13},"end":{"row":159,"column":14},"action":"insert","lines":["("]}]}],[{"group":"doc","deltas":[{"start":{"row":159,"column":31},"end":{"row":159,"column":32},"action":"insert","lines":[")"]}]}],[{"group":"doc","deltas":[{"start":{"row":163,"column":16},"end":{"row":163,"column":17},"action":"insert","lines":["("]}]}],[{"group":"doc","deltas":[{"start":{"row":163,"column":35},"end":{"row":163,"column":36},"action":"insert","lines":[")"]}]}],[{"group":"doc","deltas":[{"start":{"row":166,"column":16},"end":{"row":166,"column":17},"action":"insert","lines":["("]}]}],[{"group":"doc","deltas":[{"start":{"row":166,"column":34},"end":{"row":166,"column":35},"action":"insert","lines":[")"]}]}],[{"group":"doc","deltas":[{"start":{"row":173,"column":21},"end":{"row":173,"column":23},"action":"insert","lines":["[]"]}]}],[{"group":"doc","deltas":[{"start":{"row":173,"column":22},"end":{"row":173,"column":23},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":173,"column":24},"end":{"row":173,"column":26},"action":"insert","lines":["[]"]}]}],[{"group":"doc","deltas":[{"start":{"row":173,"column":25},"end":{"row":173,"column":26},"action":"insert","lines":["j"]}]}],[{"group":"doc","deltas":[{"start":{"row":156,"column":40},"end":{"row":157,"column":53},"action":"remove","lines":["","          puts \"n_count for (#{i},#{j}) = #{n_count}\""]}]}],[{"group":"doc","deltas":[{"start":{"row":156,"column":40},"end":{"row":157,"column":58},"action":"remove","lines":["","          cell ? (puts \"cell = cell.\") : (puts 'cell nil')"]}]}],[{"group":"doc","deltas":[{"start":{"row":157,"column":37},"end":{"row":158,"column":35},"action":"remove","lines":["","            puts \"n_count<2 & cell\""]}]}],[{"group":"doc","deltas":[{"start":{"row":159,"column":12},"end":{"row":159,"column":13},"action":"insert","lines":["#"]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":12},"end":{"row":162,"column":13},"action":"insert","lines":["#"]}]}],[{"group":"doc","deltas":[{"start":{"row":165,"column":12},"end":{"row":165,"column":13},"action":"insert","lines":["#"]}]}],[{"group":"doc","deltas":[{"start":{"row":168,"column":12},"end":{"row":168,"column":13},"action":"insert","lines":["#"]}]}],[{"group":"doc","deltas":[{"start":{"row":171,"column":12},"end":{"row":171,"column":13},"action":"insert","lines":["#"]}]}],[{"group":"doc","deltas":[{"start":{"row":158,"column":33},"end":{"row":159,"column":79},"action":"remove","lines":["","            #puts \"  next_grid(#{i},#{j}) = #{next_grid[i][j]}. (first option)\""]}]}],[{"group":"doc","deltas":[{"start":{"row":160,"column":33},"end":{"row":161,"column":95},"action":"remove","lines":["","            #puts \"  next_grid(#{i},#{j}) = #{next_grid[i][j]}.  cell=#{cell}. (second option)\""]}]}],[{"group":"doc","deltas":[{"start":{"row":162,"column":33},"end":{"row":163,"column":79},"action":"remove","lines":["","            #puts \"  next_grid(#{i},#{j}) = #{next_grid[i][j]}. (third option)\""]}]}],[{"group":"doc","deltas":[{"start":{"row":164,"column":33},"end":{"row":165,"column":80},"action":"remove","lines":["","            #puts \"  next_grid(#{i},#{j}) = #{next_grid[i][j]}. (fourth option)\""]}]}],[{"group":"doc","deltas":[{"start":{"row":166,"column":33},"end":{"row":167,"column":79},"action":"remove","lines":["","            #puts \"  next_grid(#{i},#{j}) = #{next_grid[i][j]}. (final option)\""]}]}],[{"group":"doc","deltas":[{"start":{"row":195,"column":26},"end":{"row":196,"column":0},"action":"insert","lines":["",""]},{"start":{"row":196,"column":0},"end":{"row":196,"column":9},"action":"insert","lines":["         "]}]}],[{"group":"doc","deltas":[{"start":{"row":196,"column":9},"end":{"row":196,"column":10},"action":"insert","lines":["s"]}]}],[{"group":"doc","deltas":[{"start":{"row":196,"column":10},"end":{"row":196,"column":11},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":196,"column":11},"end":{"row":196,"column":12},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":196,"column":12},"end":{"row":196,"column":13},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":196,"column":13},"end":{"row":196,"column":14},"action":"insert","lines":["p"]}]}],[{"group":"doc","deltas":[{"start":{"row":196,"column":14},"end":{"row":196,"column":16},"action":"insert","lines":["()"]}]}],[{"group":"doc","deltas":[{"start":{"row":196,"column":15},"end":{"row":196,"column":16},"action":"insert","lines":["1"]}]}],[{"group":"doc","deltas":[{"start":{"row":197,"column":9},"end":{"row":198,"column":0},"action":"insert","lines":["",""]},{"start":{"row":198,"column":0},"end":{"row":198,"column":6},"action":"insert","lines":["      "]}]}],[{"group":"doc","deltas":[{"start":{"row":198,"column":6},"end":{"row":198,"column":7},"action":"insert","lines":["n"]}]}],[{"group":"doc","deltas":[{"start":{"row":198,"column":7},"end":{"row":198,"column":8},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":198,"column":8},"end":{"row":198,"column":9},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":197,"column":9},"end":{"row":198,"column":9},"action":"remove","lines":["","      nil"]}]}],[{"group":"doc","deltas":[{"start":{"row":196,"column":15},"end":{"row":196,"column":16},"action":"insert","lines":["0"]}]}],[{"group":"doc","deltas":[{"start":{"row":196,"column":16},"end":{"row":196,"column":17},"action":"insert","lines":["."]}]}],[{"group":"doc","deltas":[{"start":{"row":196,"column":17},"end":{"row":196,"column":18},"action":"insert","lines":["5"]}]}],[{"group":"doc","deltas":[{"start":{"row":196,"column":18},"end":{"row":196,"column":19},"action":"remove","lines":["1"]}]}],[{"group":"doc","deltas":[{"start":{"row":190,"column":6},"end":{"row":190,"column":7},"action":"insert","lines":["#"]}]}],[{"group":"doc","deltas":[{"start":{"row":189,"column":6},"end":{"row":189,"column":7},"action":"insert","lines":["#"]}]}],[{"group":"doc","deltas":[{"start":{"row":201,"column":21},"end":{"row":201,"column":22},"action":"insert","lines":["1"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":11},"end":{"row":202,"column":18},"action":"remove","lines":["blinker"]},{"start":{"row":202,"column":11},"end":{"row":202,"column":12},"action":"insert","lines":["g"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":12},"end":{"row":202,"column":13},"action":"insert","lines":["l"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":13},"end":{"row":202,"column":14},"action":"insert","lines":["i"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":14},"end":{"row":202,"column":15},"action":"insert","lines":["d"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":15},"end":{"row":202,"column":16},"action":"insert","lines":["e"]}]}],[{"group":"doc","deltas":[{"start":{"row":202,"column":16},"end":{"row":202,"column":17},"action":"insert","lines":["r"]}]}]]},"ace":{"folds":[],"scrolltop":2251,"scrollleft":0,"selection":{"start":{"row":60,"column":0},"end":{"row":206,"column":2},"isBackwards":true},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":159,"state":"start","mode":"ace/mode/ruby"}},"timestamp":1426088983527}