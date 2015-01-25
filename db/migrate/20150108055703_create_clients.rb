class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :tel
      t.string :fax
      t.string :address
      t.string :mobile
      t.string :title
      t.timestamps null: false
    end
    add_index :clients, :name
    add_index :clients, :email
  end
end
