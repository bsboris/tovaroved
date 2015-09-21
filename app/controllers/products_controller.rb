class ProductsController < ApplicationController
  def index
    render locals: { products: products }
  end

  def new
    render locals: { product: product }
  end

  def create
    save_product!
    redirect_to products_url, notice: 'Продукт успешно добавлен.'
  rescue ActiveRecord::RecordInvalid => e
    render :new, locals: { product: e.record }
  end

  def edit
    render locals: { product: product }
  end

  def update
    save_product!
    redirect_to products_url, notice: 'Продукт успешно изменен.'
  rescue ActiveRecord::RecordInvalid => e
    render :edit, locals: { product: e.record }
  end

  def destroy
    product.destroy!
    flash.now[:notice] = 'Продукт удален.'
  rescue ActiveRecord::DeleteRestrictionError => e
    flash.now[:alert] = 'Не удается удалить продукт.'
  ensure
    respond_to do |format|
      format.js { render 'shared/destroy', locals: { model: product } }
      format.html { redirect_to products_url }
    end
  end

  private

  def products
    @products ||= product_scope.
      includes(:category, :brand).
      references(:category, :brand).
      sorted(params[:sort], 'products.name').
      page(params[:page])
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
