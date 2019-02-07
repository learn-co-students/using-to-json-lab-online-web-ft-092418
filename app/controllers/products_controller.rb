class ProductsController < ApplicationController

  def show 
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html {render :show}
      format.json { render json: @product.to_json(only: [:id, :name, :description, :inventory, :price])}
    end

      # current state at bedtime:
      # this is not in fact providing json or responding to requests for json
      # show has been altered to get this route but its not working
      # index has not been altered
  end

  def index
    @products = Product.all
  end

  def inventory
    product = Product.find(params[:id])
    render plain: product.inventory > 0 ? true : false
  end

  def description
    product = Product.find(params[:id])
    render plain: product.description
  end

  def new
    @product = Product.new
  end

  def create
    Product.create(product_params)
    redirect_to products_path
  end

  def data
    product = Product.find(params[:id])
    render json: product.to_json
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :inventory, :price)
  end
end
