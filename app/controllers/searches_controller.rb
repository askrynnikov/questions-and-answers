class SearchesController < ApplicationController
  def show
    authorize Search
    if search_params.present?
      @result = Search.do(search_params)
      respond_with(@result)
    end
  end

  private

  def search_params
    params.permit(:q, :page, scopes: [])
  end
end
