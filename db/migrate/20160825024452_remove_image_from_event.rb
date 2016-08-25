class RemoveImageFromEvent < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :image_path
  end
end
