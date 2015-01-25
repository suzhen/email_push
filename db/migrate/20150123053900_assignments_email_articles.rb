class AssignmentsEmailArticles < ActiveRecord::Migration
  def change
    create_table :email_articles,:id => false do |t|
      t.references :email
      t.references :article
    end
    add_index :email_articles, [:email_id]
    add_index :email_articles, [:article_id]
  end
end
