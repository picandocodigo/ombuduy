class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :fixed, default: 0
      t.integer :relevance
      t.string  :address
      t.decimal :longitude
      t.decimal :latitude
      t.string  :image_url
      t.integer :tweet_id
      t.timestamps
    end
  end
end
