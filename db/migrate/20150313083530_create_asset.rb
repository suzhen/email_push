class CreateAsset < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :attachment_file_size
      t.integer :attachment_width
      t.integer :attachment_height
      t.string :attachment   #attachment_file_name
      t.string :attachment_content_type
      t.string :attachment_url
      t.timestamps
    end
    add_reference :assets, :viewable, polymorphic: true, index: true
  end
end
