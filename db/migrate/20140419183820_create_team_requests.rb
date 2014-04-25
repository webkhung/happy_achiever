class CreateTeamRequests < ActiveRecord::Migration
  def self.up
    create_table :team_requests do |t|
      t.integer :requester_user_id, null: false
      t.integer :receiver_user_id, null: false
      t.text :message
      t.integer :status, default: 0
      t.timestamps
    end

    add_index :team_requests, [:requester_user_id, :receiver_user_id, :status], unique: true, name: 'index_requester_receiver_status'
  end

  def self.down
    drop_table :team_requests
  end
end
