class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :tweet_id
      t.string  :message
      t.timestamps
    end
  end
end
