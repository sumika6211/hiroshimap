class Post < ApplicationRecord
  belongs_to :user
  belongs_to :spot
  has_many :post_genres
  has_many :genres, through: :post_genres

  has_one_attached :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :image, presence: true
  validates :spot_id, presence: true

  def get_post_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end

end
