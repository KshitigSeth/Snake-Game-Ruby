require 'io/console'

class AteItselfError < StandardError; end
class HitWallError < StandardError; end

class Game
  attr_reader :gameboard, :snake, :food

  def initialize(max_x = 11, max_y = 11)
    @gameboard = Board.new(max_x, max_y)
    @snake = Snake.new(gameboard.width, gameboard.length)
    @food = Food.new(gameboard.width, gameboard.length, @snake.parts)
  end

  def print_board
    system('clear')
    puts "Your size is: #{snake.size} |  [Q]uit"
    puts "---------------------------"
    gameboard.board.each do |line|
      puts line.join(' ')
    end
  end

  def show
    gameboard.clear_board
    gameboard.place_food(food.coordinates)
    gameboard.place_snake(snake.parts)
    print_board
  end

  def show_message(text)
    gameboard.create_board
    gameboard.print_text(text)
    print_board
  end

  def show_start_screen
    start = false
    while start == false
      system('clear')
      puts "\n
        .........................................................................................................
        .______.......__....__...______...____....____........._______..__...__.......___.......__..___.._______.
        |..._..\\.....|..|..|..|.|..._..\\..\\...\\../.../......../.......||..\\.|..|...../...\\.....|..|/../.|...____|
        |..|_)..|....|..|..|..|.|..|_)..|..\\...\\/.../........|...(----`|...\\|..|..../..^..\\....|..'../..|..|__...
        |....../.....|..|..|..|.|..._..<....\\_...._/..........\\...\\....|....`..|.../../_\\..\\...|....<...|...__|..
        |..|\\..\\----.|..`--'..|.|..|_)..|.....|..|.........----)...|...|..|\\...|../.._____..\\..|.....\\..|..|____.
        |._|.`._____|.\\______/..|______/......|__|........|_______/....|__|.\\__|./__/.....\\__\\.|__|\\__\\.|_______|
        .........................................................................................................
        ................................................Press [S]tart............................................
      "
      key = GetKey.getkey
      sleep(0.5)
      start = true if key && compare_key(key, 's')
    end
  end

  def check_snake_position
    check_if_snake_ate_food
    check_if_snake_ate_itself
    check_if_snake_met_wall
  end

  def check_if_snake_ate_itself
    if snake.collision_self
      raise AteItselfError
    end
  end

  def check_if_snake_met_wall
    if snake.collision_wall(gameboard.width, gameboard.length)
      raise HitWallError
    end
  end

  def check_if_snake_ate_food
    if snake.head == food.coordinates
      snake.increase
      @food = Food.new(gameboard.width, gameboard.length, snake.parts)
    end
  end

  def start
    show_start_screen
    begin
      tick
    rescue AteItselfError
      show_message("Game over: You ate yourself!")
    rescue HitWallError
      show_message("Game over: You hit the wall!")
    end
  end

  def tick
    in_game = true
    while in_game
      show
      sleep(0.1)
      if key = GetKey.getkey
        in_game = execute_action(key)
      end
      snake.step
      check_snake_position
    end
    show_message("Game quit")
  end

  def execute_action(key)
    return false if compare_key(key, 'q')
    snake.turn(key)
  end

  def compare_key(key, char)
    key.chr.casecmp?(char)
  end
end