class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :image, presence: true

  def get_post_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end

end
