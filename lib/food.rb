class Food
    attr_reader :x, :y
  
    def initialize(board_max_x, board_max_y, snake_parts)
      generate_food(board_max_x, board_max_y, snake_parts)
    end
  
    def coordinates
      [x, y]
    end
  
    private
  
    def generate_food(board_max_x, board_max_y, snake_parts)
      loop do
        @x = Random.rand(board_max_x - 1)
        @y = Random.rand(board_max_y - 1)
        break unless snake_parts.include?(coordinates)  # Ensure food doesn't overlap with the snake
      end
    end
end