class Recipe < ApplicationRecord
  belongs_to :user, optional: true
  has_many :reviews, dependent: :destroy

  searchkick word_middle: [:title, :ingredients]

  mount_uploader :photo, PhotoUploader

  def search_data
    {
      title: title,
      ingredients: ingredients
    }
  end

end
