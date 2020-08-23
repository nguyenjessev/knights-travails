# frozen-string-literal: true

# This module contains classes and methods related to solving the Knight's Travails problem
module KnightsTravails
  # This class represents a chess board (in tree form)
  class Board
    attr_accessor :root

    def initialize(position)
      @root = build_tree(position)
    end

    private

    def build_tree(position, visited = [])
      current_knight = Knight.new(position)
      visited << position

      current_knight.legal_moves.each do |move|
        current_knight.next_moves << build_tree(move, visited) unless visited.include?(move)
      end

      current_knight
    end
  end

  # This class represents a knight (and possible subsequent moves)
  class Knight
    attr_accessor :x, :y, :next_moves
    attr_reader :legal_moves

    @@MOVE_VALUES = [[-2, -1],
                     [-2, 1],
                     [2, -1],
                     [2, 1],
                     [-1, -2],
                     [-1, 2],
                     [1, -2],
                     [1, 2]]

    def initialize(position)
      @x = position[0]
      @y = position[1]
      @legal_moves = find_moves
      @next_moves = []
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

  def knight_moves(start, target); end
end
