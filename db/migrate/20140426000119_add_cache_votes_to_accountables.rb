class AddCacheVotesToAccountables < ActiveRecord::Migration
  def self.up
    add_column :accountables, :cached_votes_total, :integer, :default => 0
    add_column :accountables, :cached_votes_score, :integer, :default => 0
    add_column :accountables, :cached_votes_up, :integer, :default => 0
    add_column :accountables, :cached_votes_down, :integer, :default => 0
    add_column :accountables, :cached_weighted_score, :integer, :default => 0
    add_index  :accountables, :cached_votes_total
    add_index  :accountables, :cached_votes_score
    add_index  :accountables, :cached_votes_up
    add_index  :accountables, :cached_votes_down
    add_index  :accountables, :cached_weighted_score
  end

  def self.down
    remove_column :accountables, :cached_votes_total
    remove_column :accountables, :cached_votes_score
    remove_column :accountables, :cached_votes_up
    remove_column :accountables, :cached_votes_down
    remove_column  :accountables, :cached_weighted_score
  end
end
