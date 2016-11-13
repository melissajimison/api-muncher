class CreateMyrecipes < ActiveRecord::Migration
  def change
    create_table :myrecipes do |t|
      t.string :label
      t.string :image

      t.timestamps null: false
    end
  end
end
