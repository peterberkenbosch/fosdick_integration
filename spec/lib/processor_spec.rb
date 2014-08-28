require 'spec_helper'

describe Processor do

  it 'should return a sent notification message' do
    doc = double('Documents::Shipment')
    Documents::Shipment.should_receive(:new).and_return(doc)
    Sender.should_receive(:send_doc)
    doc.should_receive(:to_xml)

    message = Processor.send_shipment(Factories.shipment, { 'fosdick_client' => 'spree' })
  end

  it 'should return shipment objects' do
    downloader = double('Downloader')
    Downloader.should_receive(:new).with('').and_return(downloader)
    downloader.should_receive(:download_files).and_return(Factories.shipment_confirmations)
    msgs = Processor.receive_results('')

    msgs.length.should eq 2
    msgs.first[:id].should be_present
  end

  it 'should return empty_notification' do

    downloader = double('Downloader')
    Downloader.should_receive(:new).with('').and_return(downloader)
    downloader.should_receive(:download_files).and_return([])
    msg = Processor.receive_results('')

    msg.should =~ /available for download/
  end
end
