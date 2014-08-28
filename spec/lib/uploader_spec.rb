require 'spec_helper'

describe Uploader do

  describe "#process" do

    it 'should upload documents' do
      VCR.use_cassette('upload') do
        res = Uploader.new('fosdick-test').process('testing.txt', 'fhdfhdfhjdfhjfdhjdfj')
        expect(res.to_s.include? 'testing.txt?').to eq true
      end
    end
  end
end
