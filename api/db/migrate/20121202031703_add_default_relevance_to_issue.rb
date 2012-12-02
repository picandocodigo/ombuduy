class AddDefaultRelevanceToIssue < ActiveRecord::Migration
  def change
    change_column :issues, :relevance, :integer, default: 0
  end
end
