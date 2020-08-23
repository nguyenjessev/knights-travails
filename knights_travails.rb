# frozen-string-literal: true

module KnightsTravails
  # This class represents a knight/board positions (and possible subsequent moves)
  class Knight
    attr_accessor :x, :y
    attr_reader :possible_moves, :previous_position

    @@MOVE_VALUES = [[-2, -1],
                     [-2, 1],
                     [2, -1],
                     [2, 1],
                     [-1, -2],
                     [-1, 2],
                     [1, -2],
                     [1, 2]]

    def initialize(position, previous_position = [])
      @x = position[0]
      @y = position[1]
      @possible_moves = find_moves(previous_position)
    end

    private

    def find_moves(previous_position)
      moves = []

      @@MOVE_VALUES.each do |move|
        new_move = [x + move[0], y + move[1]]

        moves << new_move if valid_move?(new_move) && previous_position != new_move
      end

      moves
    end

    def valid_move?(move)
      return true if move[0].between?(0, 7) && move[1].between?(0, 7)

      false
    end
  end
end
