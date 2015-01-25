class AssignmentsEmailGroups < ActiveRecord::Migration
  def change
    create_table :email_groups,:id => false do |t|
      t.references :email
      t.references :group
    end
    add_index :email_groups, [:email_id]
    add_index :email_groups, [:group_id]
  end
end
