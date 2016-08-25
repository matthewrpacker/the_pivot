class RemoveImageAttachmentFromEvent < ActiveRecord::Migration[5.0]
  def change
    remove_attachment :events, :upload_image
  end
end
