class AddCountryCodeToLocation < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :location_code, :string
  end
end
