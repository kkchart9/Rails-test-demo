class CreateCats < ActiveRecord::Migration[7.0]
  def change
    create_table :cats do |t|
      t.string :name
      t.string :age
      t.string :integer

      t.timestamps
    end
  end
end
