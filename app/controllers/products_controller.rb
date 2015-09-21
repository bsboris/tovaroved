class ProductsController < ApplicationController
  def index
    render locals: { products: products }
  end

  def new
    render locals: { product: product }
  end

  def create
    save_product!
    redirect_to products_url
  rescue ActiveRecord::RecordInvalid => e
    render :new, locals: { product: e.record }
  end

  def edit
    render locals: { product: product }
  end

  def update
    save_product!
    redirect_to products_url
  rescue ActiveRecord::RecordInvalid => e
    render :edit, locals: { product: e.record }
  end

  def destroy
    product.destroy!
    redirect_to products_url
  end

  private

  def products
    @products ||= product_scope.all
  end

  def product
    @product ||= if params[:id].present?
      product_scope.find(params[:id])
    else
      product_scope.new
    end
  end

  def save_product!
    product.attributes = product_params
    product.save!
  end

  def product_scope
    Product.all
  end

  def product_params
    if params[:product].present?
      params.require(:product).permit(:name, :brand_id, :category_id, :price, store_ids: [])
    else
      {}
    end
  end
end
