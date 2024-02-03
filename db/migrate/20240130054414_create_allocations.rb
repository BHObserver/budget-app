class CreateAllocations < ActiveRecord::Migration[7.1]
  def change
    create_table :allocations do |t|
      t.references :expense, null: false, foreign_key: true
      t.references :payment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
