class AddUserTypeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, default: 'Unnamed user'
    add_column :users, :user_type, :integer, default: 0
  end
end
