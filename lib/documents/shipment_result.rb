module Documents
  class ShipmentResult
    def initialize(contents)
      attrs               = contents.split(' ')
      @external_order_num = attrs[0]
      @ship_date          = attrs[1]
      @carrier_code       = attrs[2]
      @tracking_num       = attrs[3]
      @fosdick_order_num  = attrs[4]
      @job_number         = attrs[5]
      @run_number         = attrs[6]
      @run_date           = attrs[7]
    end

    def to_message
      {
        id: @external_order_num,
        status: 'shipped',
        tracking: @tracking_num
      }
    end
  end
end
