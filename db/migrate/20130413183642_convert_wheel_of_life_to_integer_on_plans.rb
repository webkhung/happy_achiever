class ConvertWheelOfLifeToIntegerOnPlans < ActiveRecord::Migration
  def up
    remove_column :plans, :wheel_of_life
    add_column :plans, :wheel_of_life, :integer
  end

  def down
    remove_column :plans, :wheel_of_life
    add_column :plans, :wheel_of_life, :string
  end
end
