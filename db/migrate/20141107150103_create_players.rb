class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :tournament_id
      t.integer :victory_points_sum, default: 0
      t.integer :battle_points_sum, default: 0
      t.string :name
      t.string :surname

      t.timestamps
    end
  end
end
