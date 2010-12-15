
Image.class_eval do
  extend S3::Attachment
  send_attachments_to_s3(self) if S3.enabled?
end

