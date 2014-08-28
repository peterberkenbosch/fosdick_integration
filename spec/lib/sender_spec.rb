require 'spec_helper'

describe Sender do

  it 'should send a shipment' do
    VCR.use_cassette('send_shipment') do
      res = Sender.send_doc(Factories.shipment_xml, { 'fosdick_client' => '' })
      res['UnitycartOrderResponse']['OrderResponse']['SuccessCode'].should eq 'True'
    end
  end

  it 'should raise error for invalid response' do
    Sender.should_receive(:post).and_return(Factories.errors[rand(4)])

    begin
      Sender.send_doc(Factories.shipment_xml, { 'fosdick.client' => '' })
    rescue => e
      e.message.include?('ErrorCode').should eq true
    end
  end
end
