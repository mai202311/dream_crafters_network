class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :body,       null:false
      t.references :user,   foreign_key: true
      t.integer :tag_id
      t.integer :status,    default: 0, null: false
      t.timestamps
    end
  end
end
