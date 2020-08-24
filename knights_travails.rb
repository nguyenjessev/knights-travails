# frozen-string-literal: true

# This module contains classes and methods related to solving the Knight's Travails problem
module KnightsTravails
  # This class represents a chess board (in tree form)
  class Board
    attr_accessor :root

    def initialize(position)
      @root = Knight.new(position)
    end

    def find_path(target)
      queue = [root]
      visited = []

      until queue.empty?
        current_knight = queue.shift
        return current_knight.pos if current_knight.pos == target

        return build_path(Knight.new(target, current_knight)) if current_knight.legal_moves.include?(target)

        visited << current_knight.pos

        current_knight.legal_moves.each do |move|
          queue << Knight.new(move, current_knight) unless visited.include?(move)
        end
      end

      nil
    end

    private

    def build_path(endpoint)
      path = []

      current_node = endpoint

      until current_node.nil?
        path.unshift(current_node.pos)
        current_node = current_node.parent
      end

      path
    end
  end

  # This class represents a knight (and possible subsequent moves)
  class Knight
    attr_accessor :x, :y, :parent
    attr_reader :legal_moves

    @@MOVE_VALUES = [[-2, -1],
                     [-2, 1],
                     [2, -1],
                     [2, 1],
                     [-1, -2],
                     [-1, 2],
                     [1, -2],
                     [1, 2]]

    def initialize(position, parent = nil)
      @x = position[0]
      @y = position[1]
      @legal_moves = find_moves
      @parent = parent
    end

    def pos
      [x, y]
    end

    private

    def find_moves
      moves = []

      @@MOVE_VALUES.each do |move|
        new_move = [x + move[0], y + move[1]]
        moves << new_move if valid_move?(new_move)
      end

      moves
    end

    def valid_move?(move)
      return true if move[0].between?(0, 7) && move[1].between?(0, 7)

      false
    end
  end
end

def knight_moves(start, target)
  board = KnightsTravails::Board.new(start)

  path = board.find_path(target)

  p path
end
