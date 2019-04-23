class AddArticles < ActiveRecord::Migration[5.2]
  def self.up
    create_table :articles do |t|
      t.integer :instapaper_id
      t.string :title
      t.text :body
      t.boolean :printed
      t.boolean :starred
      t.timestamp :saved_at
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
