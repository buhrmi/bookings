class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :google_id
      t.string :name
      t.string :artist_name
      t.string :email
      t.boolean :email_verified
      t.boolean :admin

      t.timestamps
    end
  end
end
