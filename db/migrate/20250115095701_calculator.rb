class Calculator < ActiveRecord::Migration[7.1]
  def change
    create_table :calculators do |t|
      t.string :input, null: false
      t.string :variant, null: false
      t.string :operation, null: false
      t.decimal :result
      t.jsonb :meta_data, default: {}

      t.timestamps
    end

    add_index :calculators, :variant
    add_index :calculators, :operation
  end
end
