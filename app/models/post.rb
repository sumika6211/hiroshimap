class Post < ApplicationRecord
  belongs_to :user
  belongs_to :spot
  has_many :post_genres
  has_many :genres, through: :post_genres
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_many_attached :images

  validates :name, presence: true
  validates :introduction, presence: true
  validates :images, presence: true
  validates :spot_id, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.favorited_order
    self.joins(:favorites).group("favorites.post_id").order("count(favorites.post_id) desc")
  end

end