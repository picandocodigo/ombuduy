class AddUserIdAndReplyToIdToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :reply_to_id, :string
    add_column :replies, :user_id, :string
  end
end
