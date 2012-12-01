class CreateIssuesTagsJoinTable < ActiveRecord::Migration
  def change
    create_table :issues_tags do |t|
      t.integer :issue_id
      t.integer :tag_id
    end
  end
end
