class ItemsController < ApplicationController
  def index
    @all_months = {1 => "January", 2 => "February", 3 => "March", 4 => "April", 5 => "May", 6 => "June", 7 => "July", 8 => "August", 9 => "September", 10 => "October", 11 => "November", 12 => "December"}
    @items = Item.all
    hash = {}
    Item.all.each{|i| hash[i.id] = [i.name, 0]}

    if params["month"].present?
      @month = params["month"].to_i
    else
      @month = Time.now.month
    end
    
    @months = {}
    Charge.all.map {|chrg| chrg.created_at.month}.uniq.each {|mnth| @months[mnth] = @all_months[mnth]}
    charges_by_items = Charge.all.select{|chrg| chrg.created_at.month == @month}.group_by(&:item_id)
    charges_by_items.each{|k,v| hash[k][1] = v.map{|amt| amt.amount.to_i}.sum()}
    @item_wise_cost = hash.sort_by{|_, v| v[1]}.reverse
    @total_cost = hash.map{|_,v| v[1]}.sum
  end

  def edit
    @item = Item.find_by(id: params[:id])
  end

  def update
    @item = Item.find_by(id: params[:id])
    @item.name = item_params[:name]
    @item.amount = item_params[:amount]

    if @item.save
      redirect_to items_path
    else
      render 'edit'
    end
  end
  
  def show
    @item = Item.find_by(id: params[:id])
    @charges = Charge.where(item_id: @item.id).select{|chrg| chrg.created_at.month == Time.now.month}
    @total_cost = @charges.map{|c| c.amount.to_i}.sum()
    @remaining =  @item.amount.to_i - @total_cost
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.create(name: item_params[:name], amount: params[:amount])
    if @item
      redirect_to items_path, flash: { success: "Successfully Added..." }
    else
      render 'new', flash: { danger: "Error updating..." }
    end
  end

  private

  def item_params
    params.require(:item).permit(:name,:amount)
  end
end
