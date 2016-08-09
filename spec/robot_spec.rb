require_relative '../lib/robot.rb'
require_relative '../lib/table.rb'
require_relative 'spec_helper.rb'



describe 'robot_placed' do
  it "After accepting a correct place command the robot should be placed" do
    table = Table.new
    robot = Robot.new(table)
    robot.location(3,3,"NORTH")
    expect(robot.robot_placed?).to eq(true)
    robot.location(0,4,"WEST")
    expect(robot.robot_placed?).to eq(true)
    robot.location(1,0,"SOUTH")
    expect(robot.robot_placed?).to eq(true)
    robot.location(4,2,"EAST")
    expect(robot.robot_placed?).to eq(true)
    #
  end
end

# describe 'robot_ not_placed' do
#   it "An invalid place comand should not place a robot" do
#     table = Table.new
#     robot = Robot.new(table)
#     robot.location(-1,3,"NORTH")
#     puts robot.location
#     expect(robot.robot_placed?).to eq(false)
#     robot.location(0,5,"WEST")
#     expect(robot.robot_placed?).to eq(false)
#     robot.location(1,"a","SOUTH")
#     expect(robot.robot_placed?).to eq(false)
    # robot.location(4,2,"NORTHWEST")
    # expect(robot.robot_placed?).to eq(false)
#     robot.location(2,"NORTHWEST")
#     expect(robot.robot_placed?).to eq(false)
#     robot.location("NORTHWEST")
#     expect(robot.robot_placed?).to eq(false)
    # robot.location("","","")
    # expect(robot.robot_placed?).to eq(false)
#     #
#   end
# end
