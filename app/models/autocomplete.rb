module Autocomplete
  include Rails.application.routes.url_helpers
  extend self
  delegate :expand_cache_key, to: 'ActiveSupport::Cache'
  delegate :perform_caching, to: 'ActionController::Base'

  def data
    cache [Team.most_recently_updated, Player.most_recently_updated] do
      paths = Team.all.map { |t| [t.name, team_path(t)] } + Player.all.map { |p| [p.name, player_path(p)] }
      paths.each_with_object({}) { |(n, p), h| h[n] = p }
    end
  end

  def cache(key, &block)
    return yield unless perform_caching

    Rails.cache.fetch(expand_cache_key(key), &block)
  end
end
