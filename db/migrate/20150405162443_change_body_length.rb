class ChangeBodyLength < ActiveRecord::Migration
  def change
    change_column :emails, :body, :text, :limit => 4294967295
  end
end
