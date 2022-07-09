class AddKeycloakIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :keycloak_id, :string
  end
end
