class AddAdminAndStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :state, :string, default: 'live'

    User.find(1).update_attribute(:admin, true)
  end
end
