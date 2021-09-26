class RemoveImageFromArticles < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :image, :text
  end
end
