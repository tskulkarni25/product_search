class ProductsController < ApplicationController
  def index
    @products = Product.search_kick(params)
  end

  def search
    redirect_to products_path(q: params[:q], sort_by: params[:sort_by], country: params[:country], price: params[:price], price_option: params[:price_option])
  end
end
