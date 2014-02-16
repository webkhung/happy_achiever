class AddPrivacyToAchievements < ActiveRecord::Migration
  def change
    add_column :achievements, :privacy, :int, default: 0
  end
end
