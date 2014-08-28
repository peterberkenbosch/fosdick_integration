require 'spec_helper'

module Documents
  describe Shipment do

    it 'should convert a shipment to xml' do
      doc = Shipment.new(Factories.shipment('Economy (5-10 Business Days - $0.00)'), { 'fosdick_client_code' => '123456' })
      xml = doc.to_xml
      xml.include?('<?xml version="1.0"?>').should eq true
    end

    it 'should add test flag' do
      doc = Shipment.new(Factories.shipment, { 'fosdick_client_code' => '123456', 'fosdick_test' => 'YeS' })
      xml = doc.to_xml
      xml.include?('<Test>Y</Test>').should eq true
    end

    it 'should not add test flag' do
      doc = Shipment.new(Factories.shipment, { 'fosdick_client_code' => '123456', 'fosdick_test' => 'No' })
      xml = doc.to_xml
      xml.include?('<Test>Y</Test>').should eq false
    end
  end
end
