require_relative 'directions'

class Robot

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
		@robot_direction = robot_direction
	end

	#removes instance variable x so robot_placed? returns false and allows to place a new robot
	def remove
		remove_instance_variable(:@x)
	end


	#if if robot has been placed
	def robot_placed?
		!!@x
	end

end
