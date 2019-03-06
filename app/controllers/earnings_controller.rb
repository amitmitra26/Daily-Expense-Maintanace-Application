class EarningsController < ApplicationController
  def new
    @earnings = Earning.all
    @earning = Earning.new
  end

  def create
    @earning = Earning.create(amount: earning_params[:amount], desc: earning_params[:desc])
    
    if @earning
      redirect_to items_path, flash: { success: "Successfully Added..." }
    else
      render 'new', flash: { danger: "Error updating..." }
    end
  end

  def show
  end

  def index
  end

  private

  def earning_params
    params.require(:earning).permit(:amount,:desc)
  end
end
