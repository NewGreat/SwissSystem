class AddRoundNumberColumnToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :max_round_number, :integer
  end
end
