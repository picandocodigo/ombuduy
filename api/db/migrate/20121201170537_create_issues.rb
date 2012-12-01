class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :fixed
      t.integer :relevance
      t.string  :address
      t.decimal :longitude
      t.decimal :latitude
      t.string  :image_url
      t.timestamps
    end
  end
end
