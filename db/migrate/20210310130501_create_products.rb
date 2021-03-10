class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.string :img_url
      t.float :price
      t.integer :total_review

      t.timestamps
    end
  end
end
