class ProductsController < ApplicationController
  before_action :find_product, only: [ :show, :edit, :update, :destroy ]

  def index
    @products = policy_scope(Product).all
  end

  def show
    authorize @product
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = current_user.products.build(product_params)
    authorize @product
    if @product.save!
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit
    authorize @product
  end

  def update
    authorize @product
    if @product.update!(product_params)
      redirect_to product_path(@product)
    else
      render :update
    end
  end

  def destroy
    authorize @product
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :category, :picture, :description)
  end

  def find_product
    @product = Product.find(params[:id])
    authorize @product
  end

end
