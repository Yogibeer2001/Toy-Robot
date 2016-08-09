require_relative 'directions'

class Robot
	TURNING = {"LEFT" => -1, "RIGHT" => 1}

	def initialize(table)
		@table = table
		@direction = Direction.new
	end

	#valid directions comming from Direction class
	def vectors
		@direction.vectors
	end

	#setting coodinates and direction facing for robot
	def location(x, y, robot_direction)
		@x = x
		@y = y
		@facing = robot_direction
	end

	def remove
		remove_instance_variable(:@x)
	end


	#if if robot has been placed
	def robot_placed?
		!!@x
	end

	#allows to iterate through the directions not effected by amount of directions
	def rotate(direction)
		new_vector = (vectors[@facing] + TURNING[direction]) % vectors.length
		@facing = vectors.key(new_vector)
		puts "Roger, roger. I\'ve turned to the #{direction}! I\'m now facing #{@facing}"
	end

	#change of coodinates by the "MOVE" command
	def move
		if valid_move?
			puts ""
			puts "Roger, roger I\'m moving forward one field!"
			case @facing
			when "EAST" then @x += 1
			when "WEST" then @x -= 1
			when "NORTH" then @y += 1
			when "SOUTH" then @y -= 1
			end
		else
      puts "This is the end of this world and I can't go further in this direction, please change direction"
		end
	end

	#reporting by the "REPORT" command
	def report
		puts "My current location is (#{@x}, #{@y}) facing #{@facing}."
	end

	#checks if  "MOVE" command keeps robot on table
	def valid_move?
		@table.stays_on_table?(@facing, @x, @y)
	end

end
