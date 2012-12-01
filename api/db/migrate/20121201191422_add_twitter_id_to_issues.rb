class AddTwitterIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :twitter_id, :string
  end
end
