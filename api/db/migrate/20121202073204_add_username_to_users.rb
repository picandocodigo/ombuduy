class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :screenname, :string
  end
end
