class User < ApplicationRecord
  has_many :recipes
  has_many :reviews

  has_many :favorite_recipes
  has_many :favorites, through: :favorite_recipes, source: :recipe

  # follower_follows "names" the Follow join table for accessing through the follower association
  has_many :follower_follows, foreign_key: :following_id, class_name: "Follow"
  # source: :follower matches with the belong_to :follower identification in the Follow model
  has_many :followers, through: :follower_follows, source: :follower

  # following_follows "names" the Follow join table for accessing through the folling association
  has_many :following_follows, foreign_key: :follower_id, class_name: "Follow"
  # source: :following matches with the belong_to :following identification in the Follow model
  has_many :followings, through: :following_follows, source: :following

  validates :username, uniqueness: true


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :picture, PictureUploader

end
