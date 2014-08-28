require 'spec_helper'

module Documents
  describe Inventory do

    it 'should respond to to_message' do
      msg = Inventory.new(Factories.inventory).to_message
      msg[:subject].should eq "Inventory For Item 1234"
    end

    it 'should use info for inventory > 200' do
      msg = Inventory.new('123  300  500 7 8 9').to_message
      msg[:level].should eq 'info'
    end

    it 'should use warn for inventory < 200' do
      msg = Inventory.new('123  100 555 7666 8666 9666').to_message
      msg[:level].should eq 'warn'
    end
  end
end