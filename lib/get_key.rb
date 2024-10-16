module GetKey

    # Check if Win32API is accessible or not
    @use_stty = begin
      require 'Win32API'
      false
    rescue LoadError
      # Use Unix way
      true
    end
  
    # Return the ASCII code of the last key pressed, or nil if none
    def self.getkey
      if @use_stty
        system('stty raw -echo') # => Raw mode, no echo
        char = (STDIN.read_nonblock(1).ord rescue nil)
        system('stty -raw echo') # => Reset terminal mode
        return char
      else
        return Win32API.new('crtdll', '_kbhit', [], 'I').Call.zero? ? nil : Win32API.new('crtdll', '_getch', [], 'L').Call
      end
    end
  
    def self.get_direction
      case getkey
      when 119, 87  # 'w' or 'W'
        :up
      when 115, 83  # 's' or 'S'
        :down
      when 97, 65   # 'a' or 'A'
        :left
      when 100, 68  # 'd' or 'D'
        :right
      else
        nil
      end
    end
  
end  