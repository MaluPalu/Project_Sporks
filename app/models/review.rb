class Review < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :recipe, optional: true

  mount_uploader :image, ImageUploader

  # validates :rating, presence: true

end
