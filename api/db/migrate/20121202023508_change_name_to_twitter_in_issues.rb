class ChangeNameToTwitterInIssues < ActiveRecord::Migration
  def change
    rename_column :issues, :twitter_id, :tweets_id
  end
end
