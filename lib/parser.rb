class Parser

  def self.parse(files)
    msgs = []

    files.each do |f|
      f[:content].each_line do |line|
        name = f[:name]

        # skip if line contains no data
        next if line.blank? || line.match(/(Ext Order #|TRAILER RECORD|SKU)/)

        doc = Documents::ShipmentResult.new(line) if name.downcase.include? 'ship'

        msgs << doc.to_message
      end
    end

    msgs
  end
end
