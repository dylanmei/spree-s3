require 'spree_core'
require 'spree_s3_hooks'

module SpreeS3
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      S3.load_s3_yaml

      Image.class_eval do
        extend S3::Attachment
        sends_files_to_s3 if S3.enabled?
      end

      Taxon.class_eval do
        extend S3::Attachment
        sends_files_to_s3 if S3.enabled?
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
