class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    
    if params[:status].present? && @merchant.update({status: params[:status]})
      redirect_to admin_merchants_path
    elsif @merchant.update(merchant_params)
      redirect_to admin_merchant_path(@merchant)
      flash[:notice] = "Merchant Successfully Updated"
    else
      flash[:alert] = "Error: #{error_message(@merchant.errors)}"
      render :edit
    end
  end

private

  def merchant_params
    params.permit(:id, :name, :status)
  end
end