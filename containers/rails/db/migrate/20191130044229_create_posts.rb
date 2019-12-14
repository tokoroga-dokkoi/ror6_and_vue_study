class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content, null: false, default: 'No Content'
      t.float :latitude, null: true
      t.float :longitude, null: true
      t.boolean :is_public, null: false, default: false

      t.timestamps
    end
    
  end
end
