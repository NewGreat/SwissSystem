class CreateChallanges < ActiveRecord::Migration
  def change
    create_table :challanges do |t|
      t.integer :round_id
      t.integer :player1_id
      t.integer :player2_id
      t.integer :table_number
      t.integer :player1_victory_points, default: 0
      t.integer :player2_victory_points, default: 0
      t.integer :player1_battle_points, default: 0
      t.integer :player2_battle_points, default: 0
      t.boolean :finished, default: false

      t.timestamps
    end
  end
end
