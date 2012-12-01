class AddIssueIdToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :issue_id, :integer
  end
end
