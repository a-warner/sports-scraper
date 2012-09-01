class AddPlayerContentFields < ActiveRecord::Migration
  def change
    add_column :players, :news, :text
    add_column :players, :spin, :text
    add_column :players, :outlook, :text
  end
end
