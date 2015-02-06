class Parser
  def self.parse(files, type)
    if type == 'ship'
      parse_shipments(files)
    else
      parse_inventory(files)
    end
  end

  def self.parse_shipments(files)
    msgs = []

    files.each do |f|
      f[:content].each_line do |line|
        # skip if line contains no data
        next if line.blank? || line.match(/(Ext Order #|TRAILER RECORD|SKU)/)

        doc = Documents::ShipmentResult.new(line)

        msgs << doc.to_message
      end
    end

    msgs
  end

  def self.parse_inventory(files)
    msgs = []

    files.each do |f|
      f[:content].each_line do |line|
        # skip if line contains no data
        next if line.blank? || line.match(/SKU/)

        doc = Documents::Inventory.new(line)

        msgs << doc.to_message
      end
    end

    msgs
  end
end
