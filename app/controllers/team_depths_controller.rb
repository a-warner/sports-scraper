class TeamDepthsController < ApplicationController
  expose(:position) do
    Position.find_by_code!(params[:position] || "RB")
  end
end
