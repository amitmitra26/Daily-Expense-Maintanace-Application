class ChargesController < ApplicationController
  def index
    @total_cost = Charge.all.select{|chrg| chrg.created_at.month == Time.now.month}.map{|ch| ch.amount.to_i}.sum()
    @total_earning = Earning.all.select{|chrg| chrg.created_at.month == Time.now.month}.map{|ch| ch.amount.to_i}.sum()
    @savings = @total_earning - @total_cost
    @charges = Charge.all.order(created_at: :desc)
    @items = Item.all.index_by(&:id)
    @total_invest = Item.all.map{|it| it.amount.to_i}.sum()
    @extra = Charge.all.select{|chrg| chrg.created_at.month == Time.now.month && chrg.item_id == 11}.map{|ch| ch.amount.to_i}.sum()
    @cost = @total_cost - @extra
    @remaining_invest = @total_invest - @cost
    #@extra_purchase
  end

  def new
    @charge = Charge.new
    #@item_ids = Item.all.map(&:id)
    @items = Item.all.collect {|i| [ i.name, i.id ] }
  end

  def create
    #binding.pry
    @charge = Charge.create(amount: charge_params[:amount], description: charge_params[:description], item_id: charge_params[:item_id])
    if @charge
      redirect_to charges_path, flash: { success: "Successfully Added..." }
    else
      render 'new', flash: { danger: "Error updating..." }
    end
  end

  private

  def charge_params
    params.require(:charge).permit(:amount,:description,:item_id)
  end

end
