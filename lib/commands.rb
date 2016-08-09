require_relative 'robot'
require_relative 'table'

class Commands
	VALID_COMMANDS = ["PLACE X,Y,FACING", "MOVE", "LEFT", "RIGHT", "REPORT", "SELFDESTRUCT", "EXIT"]

	def initialize
		@table = Table.new
		@robot = Robot.new(@table)
		@height = @table.instance_variable_get(:@height)
		@width = @table.instance_variable_get(:@width)
		@min = @table.instance_variable_get(:@min)
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
			# puts "Please enter #{VALID_COMMANDS.join(' or ')}"
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
			when "MOVE" then @robot.move
			when "REPORT" then @robot.report
			when "LEFT" then @robot.rotate("LEFT")
			when "RIGHT" then @robot.rotate("RIGHT")
			#rotate to allow for more directions (e.g. other angles than 90 degrees)
			end
		end
	end

	#extract position and direction with validation
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

		if valid_placement?
			@robot.location(@x, @y, @robot_direction)
			puts ""
			puts "The robot has been placed at #{@x} #{@y} facing #{@robot_direction}. Let\'s go on a rampage!"
		else
			puts "..the place command is incorrectly formatted or outside the table bounds. "
			puts "The boundries of this world reach from #{@min},#{@min} up to #{@width - 1},#{@height - 1}"
			puts "A place command looks like \'PLACE 0,0,North \' "
			# puts "The tables boundries are #{table_range(@height)} x #{table_range(@width)}"
		end

	end

	#shorten if condition, for checking of corect placement
	def valid_placement?
		@table.placed_on_table?(@x, @y) && @robot.vectors.include?(@robot_direction)
	end

	#fun
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
