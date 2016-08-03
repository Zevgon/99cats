class CatRentalRequestsController < ApplicationController
  def new
    @cats = Cat.all
  end

  def create
    a = CatRentalRequest.new(rental_params)
    if a.save
      render json: a
    else
      render json: a.errors.full_messages
    end
  end

  def approve!
    if CatRentalRequest.find(params[:id]).approve!
      redirect_to :back
    else
      render text: "Something went wrong"
    end
  end

  private
  def rental_params
    params.require(:ncr_request).permit!
  end
end
