class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, :null => false #新闻标题
      t.string :author #作者
      t.string :editor #编辑
      t.string :source #新闻来源
      t.string :slug
      t.string :meta_description
      t.string :meta_keywords 
      t.datetime :available_on
      t.integer :position, :default => 0
      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :articles, :title
    add_index :articles, :available_on
    add_index :articles, :deleted_at
    add_index :articles, :slug, unique: true
  end
end
