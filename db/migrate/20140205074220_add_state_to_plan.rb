class AddStateToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :state, :string, default: 'live'
  end
end
