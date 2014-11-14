class AddTimeColumnToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :time, :integer, default: 60
  end
end
