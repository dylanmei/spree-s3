module S3
  class << self
    attr_accessor :key, :secret, :bucket

    def key
      @key || ENV['S3_KEY']
    end

    def secret
      @secret || ENV['S3_SECRET']
    end

    def bucket
      @bucket || ENV['S3_BUCKET']
    end

    def enabled?
      true unless key.blank? or secret.blank? or bucket.blank?
    end

    def load_s3_yaml
      path = File.join(::Rails.root, 'config', 's3.yml')
      file = File.read(path) if File.exist? path
      if file
        yaml = YAML.load(ERB.new(file).result)[::Rails.env]
        load_s3_config yaml.with_indifferent_access if yaml
      end
    end

    def load_s3_config(hash)
      self.key = hash[:key]
      self.secret = hash[:secret]
      self.bucket = hash[:bucket]
    end
  end

  module Attachment
    def sends_files_to_s3
      [:attachment, :icon].each do |type|
        definition = self.attachment_definitions[type]
        configure_definition_for_s3(definition) if definition
      end
    end

  private
    def configure_definition_for_s3(definition)
      definition.delete :url
      definition[:path] = definition[:path].gsub(':rails_root/public/', '')
      definition[:storage] = 's3'
      definition[:bucket] = S3.bucket
      definition[:s3_credentials] = {:access_key_id => S3.key, :secret_access_key => S3.secret}
    end
  end
end
