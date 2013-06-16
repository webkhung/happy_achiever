class AddImageUrlToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :image_url, :string
  end
end
