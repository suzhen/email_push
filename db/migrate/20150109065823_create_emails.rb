class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :subject
      t.text :body
      t.datetime :sent_at
      t.timestamps null: false
    end
    add_reference :emails, :matrix, index: true
  end
end
