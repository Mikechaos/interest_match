class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :name
      t.text :description
      t.float :lat
      t.float :lon
      t.references :user, index: true

      t.timestamps
    end
  end
end
