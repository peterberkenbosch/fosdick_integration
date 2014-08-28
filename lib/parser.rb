class Parser

  def self.parse(files)
    msgs = []

    files.each do |f|
      f[:content].each_line do |line|
        name = f[:name]

        break if name.include? 'RET'

        #skip if line contains no data
        next if line.blank? || line.match(/(Ext Order #|TRAILER RECORD|SKU)/)

        doc = Documents::ShipmentResult.new(line) if name.include? 'ship'
        # doc = Documents::Inventory.new(line) if name.include? 'inventory'

        msgs << doc.to_message
      end
    end

    return msgs
  end
end
