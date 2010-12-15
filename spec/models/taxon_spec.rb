require 'spec_helper'

describe Taxon do
  before :all do
    S3.load_s3_config(:bucket => 'a', :key => 'b', :secret => 'c')
    Taxon.sends_files_to_s3
    @definition = Taxon.attachment_definitions[:icon]
  end

  it 'should redefine the file path' do
    @definition[:path].should == 'assets/taxons/:id/:style/:basename.:extension'
  end
end