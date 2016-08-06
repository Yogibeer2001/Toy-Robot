#initializing the table
class Table
  
  #set table size
  def initialize
		@width = 5
		@height = 5
	end

 #set table cordinate system to 0
	def table_range(range)
		(0..range - 1)
	end

 #to validate placement in commands
	def placed_on_table?(x, y)
		table_range(@width).include?(x) && table_range(@height).include?(y)
	end

 #to validate move of robot within the boundries
	def stays_on_table?(facing, x, y)
		if facing == "NORTH" && table_range(@height).include?(y + 1)
			true
    elsif facing == "SOUTH" && table_range(@height).include?(y - 1)
      true
		elsif facing == "EAST" && table_range(@width).include?(x + 1)
			true
		elsif facing == "WEST" && table_range(@width).include?(x - 1)
			true
		else
			false
		end
	end
end
