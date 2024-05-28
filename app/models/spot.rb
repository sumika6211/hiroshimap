class Spot < ApplicationRecord
  belongs_to :area
  has_many :posts

  validates :name, presence: true
  validates :area_id, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

end
