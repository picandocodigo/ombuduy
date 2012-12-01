class AddImageUrlToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :image_url, :string
  end
end
