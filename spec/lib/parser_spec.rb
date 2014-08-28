require 'spec_helper'

describe Parser do

  it 'should parse files into shipment:confirm messages' do
    msgs = Parser.parse(Factories.shipment_confirmations)
    msgs.length.should eq 2
    lambda { msgs.all? { |msg| msg.has_key? :number } }.should be_true
    lambda { msgs.all? { |msg| msg.has_key? :id } }.should be_true
  end

  it 'should filter unnecessary lines' do
    msgs = Parser.parse(Factories.files)
    msgs.size.should eq 3
  end
end
