require_relative '../lib/commands.rb'
require_relative 'spec_helper.rb'


describe 'a valid command is accepted' do
  it 'valid_command? should return true if the command exists in VALID_COMMANDS' do
    command = Commands.new
    expect(command.valid_command?("LEFT")).to be_eql(true)
    expect(command.valid_command?("RIGHT")).to be_eql(true)
    expect(command.valid_command?("MOVE")).to be_eql(true)
    expect(command.valid_command?("REPORT")).to be_eql(true)
    expect(command.valid_command?("SELFDESTRUCT")).to be_eql(true)
    expect(command.valid_command?("EXIT")).to be_eql(true)
  end
end

# describe 'No move command sent before placed' do
#   it "The place command should not be sent to the robot before the robot is placed" do
#     input = "MOVE"
#     expect(!@robot.robot_placed).to eql(true)
#   end
# end
