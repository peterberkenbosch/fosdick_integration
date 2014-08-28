require 'spec_helper'

describe FosdickEndpoint do
  include Rack::Test::Methods

  let(:params) { [{ 'name' => 'fosdick_client', 'value' => 'spree' },
                      { 'name' => 'fosdick_client_code', 'value' => '123456' },
                      { 'name' => 'fosdick_amazon_key', 'value' => ENV['SPREE_AMAZON_KEY'] },
                      { 'name' => 'fosdick_amazon_secret_key', 'value' => ENV['SPREE_AMAZON_KEY'] },
                      { 'name' => 'fosdick_bucket', 'value' => 'fosdick' }] }

  before :all do
    ENV['ENDPOINT_KEY'] = 'x123'
  end

  def auth
    { 'HTTP_X_AUGURY_TOKEN' => 'x123', "CONTENT_TYPE" => "application/json" }
  end

  def app
    FosdickEndpoint
  end

  it 'responds to send_shipment call' do
    request = { message: 'shipment:ready', message_id: '123456', payload: { shipment: Factories.shipment, parameters: [ {'name' => 'fosdick_client', 'value' => 'spree' }] }}
    Processor.should_receive(:send_shipment).with(Factories.shipment, { 'fosdick_client' => 'spree' }).and_return({ notifications: [] })

    post '/send_shipment', request.to_json, auth
    last_response.body.include?("notifications").should eq true
    last_response.status.should eq 200
  end

  it 'responds to receive_results call' do
    request = { message: 'fosdick:shipment_results:poll',
                message_id: '123456',
                payload: { parameters: params }}

    Processor.should_receive(:receive_results).with('fosdick').and_return(Factories.result_message)

    post '/receive_results', request.to_json, auth
    last_response.body.include?('"shipment:confirm"').should eq true
    last_response.status.should eq 200
  end
end



