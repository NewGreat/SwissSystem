class AddTimeColumnToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :time, :integer
  end
end
