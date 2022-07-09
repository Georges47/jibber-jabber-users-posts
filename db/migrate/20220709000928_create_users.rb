class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :avatar, default: '/generic-avatar.jpg'
      t.string :display_name
      t.string :username

      t.timestamps
    end
  end
end
