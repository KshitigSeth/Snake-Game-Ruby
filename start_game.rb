# Load all Ruby files in the lib directory
Dir[File.expand_path('lib/*.rb', File.dirname(__FILE__))].each do |file|
    require file
end
    
# require 'pry'

begin
    game = Game.new
    game.start
rescue StandardError => e
    puts "An error occurred: #{e.message}"
ensure
    puts "Thanks for playing! Your final size was #{game.snake.size}\n\n"
end