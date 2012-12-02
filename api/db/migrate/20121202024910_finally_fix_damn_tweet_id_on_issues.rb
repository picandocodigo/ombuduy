class FinallyFixDamnTweetIdOnIssues < ActiveRecord::Migration
  def change
    rename_column :issues, :tweets_id, :tweet_id
  end
end
