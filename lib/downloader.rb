class Downloader

  def initialize(bucket)
    s3 = AWS::S3.new
    @bucket_name = bucket
    @bucket = s3.buckets[bucket]
  end

  def download_files
    files = []
    delete_files = []

    @bucket.objects.each do |object|
      buffer = StringIO.new("", 'w')
      object.read do |chunk|
        buffer << chunk
      end

      buffer.close
      #Uploader.new("#{@bucket_name}-clone").process object.key, buffer.string
      files << { name: object.key, content: buffer.string }
      delete_files << object.key
    end

    delete_files.each { |f| delete_file f }
    return files
  end

  private
  def delete_file(name)
    object = @bucket.objects[name]
    object.delete

    return !object.exists?
  end
end