class AddScrapedToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :scraped, :boolean, null: false, default: false
  end
end
