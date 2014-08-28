require 'spec_helper'

module Documents
  describe ShipmentResult do

    it 'should create a shipment:confirm message' do
      msg = ShipmentResult.new(Factories.confirm).to_message
      msg[:id].should eq Factories.confirm.split(' ')[0]
    end
  end
end
