class AddFinishedColumnToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :finished, :boolean, default: false
  end
end
