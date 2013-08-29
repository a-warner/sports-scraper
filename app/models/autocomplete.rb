module Autocomplete
  extend self

  def data
    Team.all.map(&:name) + Player.all.map(&:name)
  end
end
