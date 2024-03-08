class Genre < ApplicationRecord

  has_many :post_genres
  has_many :genres, through: :post_genres

  validates :name, presence: true

end
