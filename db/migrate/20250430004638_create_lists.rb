class CreateLists < ActiveRecord::Migration[8.0]
  def change
    create_table :lists do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.string :description

      t.timestamps
    end
  end
end
