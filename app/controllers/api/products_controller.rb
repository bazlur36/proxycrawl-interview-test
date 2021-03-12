class Api::ProductsController < ApplicationController

  before_action :authenticate
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :set_product, except: [:create]

  def create
    @product = Product.find_by(title: product_params[:title])
    if @product.blank?
      @product = Product.create(product_params)
      render json: {message: 'Product has been created successfully.', product: @product}, status: :ok
    else
      render json: {error: 'Product already exists.'}, status: :conflict
    end
  end

  def show
  end

  def update
    if @product.update(product_params)
      render json: {message: 'Product has been updated successfully.', product: @product}, status: :ok
    else
      render json: {error: 'Product could not be updated.'}, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      render json: {message: 'Product has been deleted successfully.'}, status: :ok
    else
      render json: {error: 'Product could not be deleted.'}, status: :unprocessable_entity
    end
  end

  private

  def authenticate
    api_key = request.headers[:TOKEN]
    if api_key.blank? || !ActiveSupport::SecurityUtils.secure_compare(api_key, ENV["PROXYCRAWL_API_KEY"])
      render json: {error: 'Unauthorized!!'}, status: :unauthorized
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :img_url, :price, :customer_review, :review_count, :asin)
  end

  def record_not_found
    render json: { error: "Product with this id could not be found!!" }, status: :not_found
  end

end
