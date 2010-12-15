require 'spec_helper'

describe Image do
  describe 'attachment definition' do
    before :all do
      S3.load_s3_config(:bucket => 'a', :key => 'b', :secret => 'c')
      Image.sends_files_to_s3
      @definition = Image.attachment_definitions[:attachment]
      @credentials = @definition[:s3_credentials]
    end

    it 'should not define a local url' do
      @definition.has_key?(:url).should be_false
    end

    it 'should redefine the file path' do
      @definition[:path].should == 'assets/products/:id/:style/:basename.:extension'
    end

    it 'should define s3 as the storage mechanism' do
      @definition[:storage].should == 's3'
    end

    it 'should define an s3 bucket' do
      @definition[:bucket].should == 'a'
    end

    it 'should define s3 credentials' do
      @credentials.should_not be_nil
      @credentials[:access_key_id].should == 'b'
      @credentials[:secret_access_key].should == 'c'
    end
  end
end
