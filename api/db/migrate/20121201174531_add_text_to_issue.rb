class AddTextToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :text, :string
  end
end
