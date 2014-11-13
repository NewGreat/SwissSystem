class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :tournament_id
      t.integer :round_number
      t.boolean :finished, default: false

      t.timestamps
    end
  end
end
