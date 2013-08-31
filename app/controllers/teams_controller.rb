class TeamsController < ApplicationController
  expose(:team)

  expose(:cache_key) { [Team.most_recently_updated, Player.most_recently_updated] }
  expose(:last_modified) { [Team.most_recent_updated_at, Player.most_recent_updated_at].max }

  def index
    if stale?(last_modified: last_modified, etag: cache_key)
      respond_to do |format|
        format.json do
          render json: Team.all, root: false, include: { players: :player_depths }
        end
      end
    end
  end
end
