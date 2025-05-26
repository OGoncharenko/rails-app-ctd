class CreateAdminUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :admin_users do |t|
      t.string :email, null: false, default: ""
      t.string :password_digest, null: false, default: ""
      t.timestamps
    end
  end
end
