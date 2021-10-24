class Article < ApplicationRecord
  has_many :article_users, dependent: :destroy
  has_many :users, through: :article_users
  has_many :comments, dependent: :destroy
  has_one_attached :image

  with_options presence: true do
    validates :image, :title, :content
  end
end
