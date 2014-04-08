class AddReceiverUserIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :receiver_user_id, :integer
  end

end
