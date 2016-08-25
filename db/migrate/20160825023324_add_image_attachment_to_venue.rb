class AddImageAttachmentToVenue < ActiveRecord::Migration[5.0]
  def change
    add_attachment :venues, :upload_image
  end
end
