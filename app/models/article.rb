class Article < ApplicationRecord
  belongs_to :user
  has_many :comments

  with_options presence: true do
    validates :image, :title, :content
  end
end
