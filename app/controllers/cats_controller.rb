class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def show
    cat = Cat.find(params[:id])
    render json: cat
  end


end
