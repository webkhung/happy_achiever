class UpdatePlanPrivacy < ActiveRecord::Migration
  def up
    Plan.update_all(privacy: 1)
  end

  def down
  end
end
