class AddStatusToVenue < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :status, :integer
  end
end
