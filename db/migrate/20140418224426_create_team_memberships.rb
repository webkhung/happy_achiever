class CreateTeamMemberships < ActiveRecord::Migration
  def self.up
    create_table :team_memberships do |t|
      t.integer :user_id, null: false
      t.integer :teammate_user_id, null: false
      t.timestamps
    end

    add_index :team_memberships, :user_id
    add_index :team_memberships, :teammate_user_id
    add_index :team_memberships, [:user_id, :teammate_user_id], unique: true
  end

  def self.down
    drop_table :team_memberships
  end
end
