class SearchController < ApplicationController
  expose(:query) { params[:query] }
  expose(:results) do
    Player.for_query(query) + Team.for_query(query)
  end

  def index

  end

  def new
    respond_to do |format|
      format.js { render partial: 'results', locals: { results: results }, content_type: 'text/html' }
      format.html
    end
  end
end
