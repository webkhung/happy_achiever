class IncreaseReasonColumnSize < ActiveRecord::Migration
  def up
    change_column :achievements, :reason, :text
  end

  def down
  end
end
