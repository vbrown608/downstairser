class CreateUsers < ActiveRecord::Migration[5.2]
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :token
      t.string :token_secret
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :users
  end
end
