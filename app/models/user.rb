class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :follower_relationships, foreign_key: :followed_id, class_name: "Relationship"
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :followed_relationships, foreign_key: :follower_id, class_name: "Relationship"
  has_many :followeds, through: :followed_relationships, source: :followed

  has_one_attached :profile_image

  validates :name, presence: true

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "defaullt-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(gravity: :center, resize: "100x100", crop: "70x70+0+0").processed
  end

  def followeds?(user)
    followeds.include?(user)
  end

end
