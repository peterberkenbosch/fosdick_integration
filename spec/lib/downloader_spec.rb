require 'spec_helper'

describe Downloader do

  before do
    Timecop.freeze('2013-12-13 16:59:49-0500')
  end

  it 'should download available files' do
    VCR.use_cassette('download') do
      files = Downloader.new('fosdick-test').download_files
      files.length.should eq 1
      f = files.first
      f[:name].should eq 'fostest.txt'
      f[:content].include?('10208879707316222-H123456').should eq true
    end
  end
end