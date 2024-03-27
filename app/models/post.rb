class Post < ApplicationRecord
  belongs_to :user
  belongs_to :spot
  has_many :post_genres
  has_many :genres, through: :post_genres
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :image, presence: true
  validates :spot_id, presence: true

  def get_post_image(width_fit, height_fit, width_crop, height_crop)
    image.variant(resize_to_fit: [width_fit, height_fit], gravity: "center", crop: "#{width_crop}x#{height_crop}+0+0").processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.favorited_order
    #self.find(Favorite.group(:post_id).order('count(post_id) desc').pluck(:post_id))
    self.joins(:favorites).group("favorites.post_id").order("count(favorites.post_id) desc")
  end
end