class AddRolesToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :roles, :string
  end
end
