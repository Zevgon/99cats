class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
    
  end

  def new
    @cat = Cat.new
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    @cat = Cat.find(params[:id])
    @cat.update(cat_params)
    redirect_to cat_url(@cat)
  end

  def create
    cat = Cat.new(cat_params)

    if cat.save
      redirect_to cat_url(cat)
    else
      render json: cat.errors.full_messages
    end
  end

  private

  def cat_params
    params.require(:cats).permit!
  end


end
