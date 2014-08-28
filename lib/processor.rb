class Processor
  def self.send_shipment(shipment, config)
    doc = Documents::Shipment.new(shipment, config)
    res = Sender.send_doc(doc.to_xml, config)

    return sent_notification(res)
  end

  def self.receive_results(bucket)
    down  = Downloader.new(bucket)
    files = down.download_files

    if files.empty?
      messages = empty_notification
    else
      ship_results = Parser.parse(files)
      messages = ship_results.select { |msg| msg.has_key? :number }
      # notifications = ship_results.select { |msg| msg.has_key? :level }
    end

    return messages
  end

  private
  def self.sent_notification(res)
    "Successfully Sent Shipment to Fosdick. Confirmation ##{res}"
  end

  def self.empty_notification
    'There were no shipment result, inventory level file, or RET files available for download'
  end
end
