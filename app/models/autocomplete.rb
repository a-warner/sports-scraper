module Autocomplete
  include Rails.application.routes.url_helpers
  extend self

  def data
    paths = Team.all.map { |t| [t.name, team_path(t)] } + Player.all.map { |p| [p.name, player_path(p)] }
    paths.each_with_object({}) { |(n, p), h| h[n] = p }
  end
end
