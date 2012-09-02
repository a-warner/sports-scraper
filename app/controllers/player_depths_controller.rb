class PlayerDepthsController < ApplicationController
  expose(:team)
  expose(:depths) { team.player_depths }
end
