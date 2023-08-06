class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = BulkDiscount.all
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)

    if @bulk_discount.save
      flash[:notice] = "Bulk discount created"
      redirect_to merchant_bulk_discounts_path(@merchant)
    else 
      flash[:notice] = "Error: percentage or quantity threshold enter incorrectly"
      render :new
    end
  end

  def destroy
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path
  end


private
  def bulk_discount_params
    if params[:bulk_discount].present?
      params.require(:bulk_discount).permit(:id, :percentage, :quantity_threshold)
    else
      params.permit(:percentage, :quantity_threshold)
    end
  end
end