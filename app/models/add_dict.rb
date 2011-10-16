class AddDict < ActiveRecord::Base
  mount_uploader :file, FileUploader
end
