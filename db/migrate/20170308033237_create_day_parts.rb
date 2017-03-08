class CreateDayParts < ActiveRecord::Migration[5.0]
  def change
    create_table :day_parts do |t|
      t.references :location, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
