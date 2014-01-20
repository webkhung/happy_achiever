class RenamePlanImageUrlToImagePath < ActiveRecord::Migration
  def up
    rename_column :plans, :image_url, :image_path
  end

  def down
    rename_column :plans, :image_path, :image_url
  end
end
