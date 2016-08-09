require_relative 'robot'
require_relative 'table'

class Commands
	VALID_COMMANDS = ["PLACE X,Y,FACING", "MOVE", "LEFT", "RIGHT", "REPORT", "SELFDESTRUCT", "EXIT"]
	TURNING = {"LEFT" => -1, "RIGHT" => 1}

	#grabing variables from robot and the table
	def initialize
		@table = Table.new
		@robot = Robot.new(@table)
		@height = @table.instance_variable_get(:@height)
		@width = @table.instance_variable_get(:@width)
		@min = @table.instance_variable_get(:@min)
		@x = @robot.instance_variable_get(:@x)
		@y = @robot.instance_variable_get(:@y)
		@robot_direction = @robot.instance_variable_get(:@robot_direction)
	end

	#introduction
	def greeting
		puts "Welcome commander."
		puts "The table needs to be invaded and we require your expertise to navigate a terminator-robot to rampage this little world (from #{@min},#{@min} up to #{@width - 1},#{@height - 1})"
		puts "The only commands it will accept are ..."
		puts ""
		puts "1) #{VALID_COMMANDS[0]} .... will place the robot on the table (e.g.: place 1,1,north)"
		puts "(X => #{@min} to #{@width - 1})..(y => #{@min} to #{@height - 1})..(facing => #{@robot.vectors.keys})"
		puts "2) #{VALID_COMMANDS[1]} .... will move the robot in the direction its facing"
		puts "3) #{VALID_COMMANDS[2]} .... will turn the robot anti-clockwise by 90 degrees"
		puts "4) #{VALID_COMMANDS[3]} .... will turn the robot on the clockwise by 90 degrees"
		puts "5) #{VALID_COMMANDS[4]} .... will report the robots current location"
		puts "6) #{VALID_COMMANDS[5]} .... will destroy the robot and exit the program"
		puts "7) #{VALID_COMMANDS[6]} .... will exit the program"
	end

	#validates command from command array
	def valid_command?(command)
		VALID_COMMANDS.include?(command)
	end

 # after executed command as for new command
	def input_command
		loop do
			puts ""
			puts "What are your commands my master?"
			give_command(gets.chomp.upcase)
		end
	end


 # what happens at which command
	def give_command(command)
		if command.start_with? "PLACE"
			if @robot.robot_placed?
				puts ""
				puts "Only one robot permitted in this small world"
			else
				place(command)
			end
		elsif command == "EXIT"
			exit
		elsif !valid_command?(command)
			puts ""
			puts "Sorry but \"#{command}\" is not a valid command"
		elsif !@robot.robot_placed?
			puts ""
			puts "Sorry but you need to place the robot before \"#{command}\" will be accepted"
		else
			case command
			when "SELFDESTRUCT" then destruct
			when "MOVE" then move
			when "REPORT" then report
			when "LEFT" then rotate("LEFT")
			when "RIGHT" then rotate("RIGHT")
			#rotate to allow for more directions (e.g. other angles than 90 degrees)
			end
		end
	end

	#shorten if-condition, for checking of correct placement and feeding more conditions later if required
	def valid_placement?
		@table.placed_on_table?(@x, @y) && @robot.vectors.include?(@robot_direction)
	end

	#extract position and direction with validation from place command
	def place(command)
		command.sub!("PLACE", "")
		if (command =~ /\s*\d,\d,\w+/).nil?
			puts ""
      puts "You forgot to tell the robot where to be placed or .."
    else
  		@x, @y, @robot_direction = command.split(",")
  		@x = number_or_nil(@x)
  		@y = number_or_nil(@y)
    end
		#validates the location of the placement
		if valid_placement?
			@robot.location(@x, @y, @robot_direction)
			puts ""
			puts "The robot has been placed at #{@x} #{@y} facing #{@robot_direction}. Let\'s go on a rampage!"
		else
			puts "..the place command is incorrectly formatted or outside the table bounds. "
			puts "The boundries of this world reach from #{@min},#{@min} up to #{@width - 1},#{@height - 1}"
			puts "A place command looks like \'PLACE 0,0,North \' "
		end
	end

	#checks if  "MOVE" command keeps robot on table
	def valid_move?
		@table.stays_on_table?(@robot_direction, @x, @y)
	end

	#change of coodinates by the "MOVE" command
	def move
		if valid_move?
			puts ""
			puts "Roger, roger I\'m moving forward one field!"
			case @robot_direction
			when "EAST" then @x += 1
			when "WEST" then @x -= 1
			when "NORTH" then @y += 1
			when "SOUTH" then @y -= 1
			end
		else
      puts "This is the end of this world and I can't go further in this direction, please change direction"
		end
	end

	#allows to iterate through the directions not effected by amount of directions, therefore scalable and easy to add more directions
	def rotate(direction)
		new_vector = (@robot.vectors[@robot_direction] + TURNING[direction]) % @robot.vectors.length
		@robot_direction = @robot.vectors.key(new_vector)
		puts "Roger, roger. I\'ve turned to the #{direction}! I\'m now facing #{@robot_direction}"
	end

	#reporting by the "REPORT" command
	def report
		puts "My current location is (#{@x}, #{@y}) facing #{@robot_direction}."
	end

	#destroying existing robot and enable creation of new robot
	def destruct
		puts ""
		puts "...whyyyyyyyyyy!!!"
		puts "...5...I want to live..."
		puts "...4...please,....master...."
		puts "...3...don\'t do it.."
		puts "...2...my lives work..."
		puts "...1...I\'ll be back!"
		puts " BOOOOOOMMM!!!..."
		puts "Your robot exploded... The world is save (until you place a new robot)"
		@robot.remove
	end

	# Prevents against a non-numberic input in the place command. a.to_i => 0 which could hide an error. Thus instead nil is used.
	def number_or_nil(string)
	  Integer(string)
		rescue ArgumentError
	  	nil
	end
end
