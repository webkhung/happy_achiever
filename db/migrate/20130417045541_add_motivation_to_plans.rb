class AddMotivationToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :motivation, :integer
  end
end
