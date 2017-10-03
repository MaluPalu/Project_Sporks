class User < ApplicationRecord
  has_many :recipes
  has_many :reviews

  has_many :favorite_recipes
  has_many :favorites, through: :favorite_recipes, source: :recipe

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :picture, PictureUploader

end
