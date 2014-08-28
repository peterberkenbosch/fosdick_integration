require 'securerandom'
Dir['./lib/**/*.rb'].each { |f| require f }

class FosdickEndpoint < EndpointBase::Sinatra::Base

  before do
    AWS.config(access_key_id: @config['fosdick_amazon_key'],
               secret_access_key: @config['fosdick_amazon_secret_key']) if @config
  end

  post '/add_shipment' do
    begin
      msg = Processor.send_shipment(@payload[:shipment], @config)
      code = 200
    rescue => e
      msg  = error_message(e)
      code = 500
    end

    set_summary msg
    process_result code
  end

  post '/get_shipments' do
    begin
      shipments  = Processor.receive_results(@config['fosdick_bucket'])
      code = 200
    rescue => e
      msg  = error_message(e)
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

  def base_msg
    { message_id: @message[:message_id] }
  end

  def error_message(e)
    e.message
  end
end
