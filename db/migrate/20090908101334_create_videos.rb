class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.integer :category_id

      t.string :title
      t.string :description
      t.string :thumbnail_url
      t.integer :views, :null => false, :default => 0
      t.boolean :featured, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
