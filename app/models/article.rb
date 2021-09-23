class Article < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :image, :title, :content
  end
end
