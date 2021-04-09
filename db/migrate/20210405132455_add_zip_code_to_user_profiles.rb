class AddZipCodeToUserProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :user_profiles, :zip_code, :string
  end
end
