class AddPrivacyToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :privacy, :int, default: 0
  end
end
