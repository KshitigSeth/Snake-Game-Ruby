class Board
    attr_reader :length, :width, :board
  
    def initialize(width, length)
      @length = length
      @width = width
      create_board
    end
  
    def center
      [board.length / 2, board.first.length / 2]
    end
  
    def print_text(text)
      char_center = text.length / 2
      i = 0
      text.chars.each do |char|
        board[center.first][center.last - char_center + i] = char
        i += 1
      end
    end
  
    def create_board
      @board = Array.new(length) { Array.new(width, '.') }
    end
  
    def place_snake(snake_parts)
      snake_parts.each do |part|
        board[part[0]][part[1]] = "\e[32m■\e[0m"
      end
    end
  
    def place_food(food_coords)
      board[food_coords[0]][food_coords[1]] = "\e[31m♦\e[0m"
    end
  
    def clear_board
      create_board  # Resets the board
    end
  
    def display
      board.each do |row|
        puts row.join(' ')
      end
    end
end