class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :post_image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :post_image, presence: true

end
