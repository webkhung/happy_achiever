class AddStateToFocusArea < ActiveRecord::Migration
  def change
    add_column :focus_areas, :state, :string, default: 'live'
  end
end
