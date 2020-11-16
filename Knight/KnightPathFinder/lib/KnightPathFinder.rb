require_relative "PolyTree.rb"
require "byebug"

class KnightPathFinder

    attr_reader :considered_positions, :pos, :root_node

    POSSIBLE_MOVES = [[1,2],[-1,2],[1,-2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1]]
    def initialize(pos, considered_positions = [])    # start point
        @pos = pos
        @root_node = PolyTreeNode.new(pos) #pos is PolyTree.@value
        @considered_positions = considered_positions 
    end
    
    # [[1,2],[-1,2],[1,-2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1]]    index(0..7)
    def self.valid_moves(pos)   # any point? list of all possible moves for knight
        # possible_move = [[1,2],[-1,2],[1,-2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1]]
        row, col = pos
        new_move = []
        POSSIBLE_MOVES.each do |move_range|
            row_change, col_change = move_range
            row_new = row + row_change
            col_new = col + col_change
            if row_new.between?(0,7) && col_new.between?(0,7)
                new_move << [row_new, col_new]
            end
        end
        new_move
    end

    def new_move_positions(pos)
        @considered_positions << pos
        new_move = KnightPathFinder.valid_moves(pos)
        new_move.select{|position| !@considered_positions.include?(position)}
    end


    def build_move_tree  # list all moves from current move.
         # [0,0]
        queue = [@root_node]
        until queue.empty?
            pos = queue.first.value
            poss = self.new_move_positions(pos)
            poss.each do |ele| #[1,2] [2,1]
                new_node = PolyTreeNode.new(ele)
                new_node.parent = queue.first
                queue << new_node                                      
            end 
            queue.shift  
        end
    end

    # def find_path(position)  # Method to determine best possible move from #build_move_tree list
    #     # current_pos = @root_node.value
    #     # path = [self.pos]
    #     # if self.pos == position #knight 
    #     #     return path
    #     # else 
    #     #     self.build_move_tree 
    #     #     if @root_node.nil? == false
    #     #         @root_node.children.each do |child|
    #     #             knight = KnightPathFinder.new(child.value, @considered_positions)
                    
    #     #             path += knight.find_path(position)
    #     #         end
    #     #     end
    #     # end
    #     # path
    # end

end 

p kpf = KnightPathFinder.new([0, 0])
# p kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
# p kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]

# want to be able to find paths to end positions such as...
# kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
# kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]

# Root_Move
#   |
#All Valid Moves

# /       |             \
# AVMs     AVMS             AVMS

# (0,0) => (3,3)
# find path([3,3])
# [0,0] => [1,2],[2,1]
# check is this the point we want?
# yes  path << all path
# no keep going
# [1,2] => [] [] [][ ][ ][]
# build move tree for child 
# check again