class AddChallangesCountToPlayers < ActiveRecord::Migration
  def up
    add_column :players, :challanges_count, :integer, default: 0
    Player.all.each do |player|
      player.update_attribute :challanges_count, player.challanges.where(finished: true).count
    end
  end

  def down
    remove_column :players, :challange_count
  end
end
