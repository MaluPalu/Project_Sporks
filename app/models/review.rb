class Review < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :recipe, optional: true

  mount_uploader :image, ImageUploader

end
