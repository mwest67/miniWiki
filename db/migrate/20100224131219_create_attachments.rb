class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string :file_name
      t.integer :page_id

      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
