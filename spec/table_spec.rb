require_relative '../lib/table.rb'
require_relative 'spec_helper.rb'

#check good moves
describe 'valid movement' do
  it "Table should allow movement in bounds of table" do
    table = Table.new
    expect(table.stays_on_table?("SOUTH",2,3)).to be_eql(true)
    expect(table.stays_on_table?("WEST",2,3)).to be_eql(true)
    expect(table.stays_on_table?("NORTH",2,3)).to be_eql(true)
    expect(table.stays_on_table?("EAST",2,3)).to be_eql(true)
  end
end

#check bad moves
describe 'invalid movement' do
  it "Table should return false if a robot movement would drive robot off table" do
    table = Table.new
    expect(table.stays_on_table?("NORTH",2,4)).to eq(false)
    expect(table.stays_on_table?("EAST",4,1)).to eq(false)
    expect(table.stays_on_table?("SOUTH",3,0)).to eq(false)
    expect(table.stays_on_table?("WEST",0,3)).to eq(false)
  end
end
# check table inside
describe 'allow placement' do
  it "Table allows placement if within bounds of table" do
    table = Table.new
    expect(table.placed_on_table?(0,0)).to be_eql(true)
    expect(table.placed_on_table?(0,1)).to be_eql(true)
    expect(table.placed_on_table?(0,2)).to be_eql(true)
    expect(table.placed_on_table?(0,3)).to be_eql(true)
    expect(table.placed_on_table?(0,4)).to be_eql(true)
    expect(table.placed_on_table?(1,0)).to be_eql(true)
    expect(table.placed_on_table?(1,1)).to be_eql(true)
    expect(table.placed_on_table?(1,2)).to be_eql(true)
    expect(table.placed_on_table?(4,4)).to be_eql(true)
    expect(table.placed_on_table?(3,3)).to be_eql(true)
    expect(table.placed_on_table?(2,2)).to be_eql(true)
    expect(table.placed_on_table?(2,4)).to be_eql(true)
    expect(table.placed_on_table?(3,4)).to be_eql(true)

  end
end
#check table outside
describe 'invalid placement' do
  it "table will not allow placement outside of it's bounds" do
    table = Table.new
    expect(table.placed_on_table?(0,5)).to be_eql(false)
    expect(table.placed_on_table?(-1,0)).to be_eql(false)
    expect(table.placed_on_table?(2,5)).to be_eql(false)
    expect(table.placed_on_table?(-2,3)).to be_eql(false)
    expect(table.placed_on_table?(-2,6)).to be_eql(false)
  end
end
