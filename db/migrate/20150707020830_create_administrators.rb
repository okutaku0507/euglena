class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.string :login_name, null: false
      t.string :hashed_password, null: false

      t.timestamps null: false
    end
    add_index :administrators, :login_name
  end
end
