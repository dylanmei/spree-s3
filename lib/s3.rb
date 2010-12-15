module S3
  class << self
    attr_accessor :key, :secret, :bucket

    def key
      ENV['S3_KEY'] || @key
    end

    def secret
      ENV['S3_SECRET'] || @secret
    end

    def bucket
      ENV['S3_BUCKET'] || @bucket
    end

    def enabled?
      true unless key.blank? or secret.blank? or bucket.blank?
    end

    def load_s3_yaml
      file = File.read(File.join(::Rails.root, 'config', 's3.yml'))
      if file
        yaml = YAML.load(ERB.new(file).result)[::Rails.env]
        load_s3_config yaml.with_indifferent_access
      end
    end

    def load_s3_config(hash)
      self.key = hash[:key]
      self.secret = hash[:secret]
      self.bucket = hash[:bucket]
    end
  end

  module Attachment
    def send_attachments_to_s3(asset, type = :product)
      asset.has_attached_file :attachment,
        :styles => {
          :mini => '48x48>', :small => '100x100>', :product => '240x240>', :large => '600x600>'
        }, :default_style => :product,
        :path => "assets/#{type.to_s}s/:id/:style/:basename.:extension",
        :storage => 's3',
        :bucket => S3.bucket,
        :s3_credentials => {
          :access_key_id => S3.key, :secret_access_key => S3.secret
        }
    end
  end
end
