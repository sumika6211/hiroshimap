class Spot < ApplicationRecord
  belongs_to :area
  has_many :posts

  validates :name, presence: true

end
