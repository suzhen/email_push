class AddVolumeToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :volume, :integer
    add_index :articles,:volume
  end
end
