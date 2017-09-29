class User < ApplicationRecord
  has_many :recipes
  # get rid of this comment – if you want, you can add all these modules for now
  # and delete as you realize you do not need / want them

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
