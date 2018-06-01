class Community < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  has_many :homes_liked, through: :likes, source: :user
end
