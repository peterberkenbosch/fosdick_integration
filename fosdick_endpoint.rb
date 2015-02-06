require 'securerandom'
Dir['./lib/**/*.rb'].each { |f| require f }

class FosdickEndpoint < EndpointBase::Sinatra::Base

  before do
    AWS.config(access_key_id: @config['amazon_key'],
               secret_access_key: @config['amazon_secret_key']) if @config
  end

  post '/add_shipment' do
    begin
      msg = Processor.send_shipment(@payload[:shipment], @config)
      code = 200
    rescue => e
      msg  = e.message
      code = 500
    end

    set_summary msg
    process_result code
  end

  post '/get_shipments' do
    begin
      shipments  = Processor.receive_results(@config['bucket'], 'ship')
      code = 200
    rescue => e
      msg  = e.message
      code = 500
    end

    if shipments.is_a?(Array)
      shipments.each do |shipment|
        add_object :shipment, shipment
      end
      set_summary "#{shipments.length} shipments imported from Fosdick."
    else
      set_summary shipments
    end
    process_result code
  end

  post '/get_inventory' do
    begin
      inventories  = Processor.receive_results(@config['bucket'], 'inventory')
      code = 200
    rescue => e
      msg  = e.message
      code = 500
    end

    if inventories.is_a?(Array)
      inventories.each do |inventory|
        add_object :inventory, inventory
      end
      set_summary "#{inventories.length} inventory imported from Fosdick."
    else
      set_summary inventories
    end
    process_result code
  end
end
