class AddCompanyAndPostcodeToClient < ActiveRecord::Migration
  def change
    add_column :clients,:company, :string
    add_column :clients,:postcode,:string
    add_index :clients,:company
  end
end
