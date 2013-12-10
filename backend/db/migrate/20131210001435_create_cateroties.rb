class CreateCateroties < ActiveRecord::Migration
  def change
    create_table :cateroties do |t|
      t.string :name

      t.timestamps
    end

    add_column :interests, :category_id, :integer
    add_index :interests, :category_id
  end
end
