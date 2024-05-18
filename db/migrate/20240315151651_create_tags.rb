class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name,     null:false
      t.timestamps
    end
    add_index :tags, [:name], unique: true #同じタグ名が作成されないようにするユニーク制約
  end
end
