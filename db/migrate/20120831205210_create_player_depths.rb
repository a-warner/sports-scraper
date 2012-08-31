class CreatePlayerDepths < ActiveRecord::Migration
  def change
    create_table :player_depths do |t|
      t.references :team
      t.references :player
      t.references :position
      t.integer :depth
      t.timestamps
    end
  end
end
