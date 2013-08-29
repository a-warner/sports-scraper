class SearchController < ApplicationController
  expose(:query) { params[:query] }
  expose(:results) do
    Player.for_query(query) + Team.for_query(query)
  end

  def new
    if results.one? && !request.xhr?
      redirect_to polymorphic_path(results.first), status: :found
      return
    end

    respond_to do |format|
      format.js { render partial: 'results', locals: { results: results }, content_type: 'text/html' }
      format.html
    end
  end
end
