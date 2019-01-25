class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :google_id
      t.string :name
      t.string :artist_name
      t.string :email
      t.boolean :email_verified
      
      t.string :google_access_token
      t.string :google_refresh_token
      t.string :google_calendar_id

      t.boolean :admin

      t.timestamps
    end
  end
end
