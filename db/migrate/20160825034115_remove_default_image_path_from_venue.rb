class RemoveDefaultImagePathFromVenue < ActiveRecord::Migration[5.0]
  def change
    remove_column :venues, :image_path
    add_column :venues, :image_path, :text
  end
end
