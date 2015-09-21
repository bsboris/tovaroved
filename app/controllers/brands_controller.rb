class BrandsController < ApplicationController
  def index
    render locals: { brands: brands }
  end

  def new
    render locals: { brand: brand }
  end

  def create
    save_brand!
    redirect_to brands_url
  rescue ActiveRecord::RecordInvalid => e
    render :new, locals: { brand: e.record }
  end

  def edit
    render locals: { brand: brand }
  end

  def update
    save_brand!
    redirect_to brands_url
  rescue ActiveRecord::RecordInvalid => e
    render :edit, locals: { brand: e.record }
  end

  def destroy
    brand.destroy!
    redirect_to brands_url
  end

  private

  def brands
    @brands ||= brand_scope.ordered_by_name
  end

  def brand
    @brand ||= if params[:id].present?
      brand_scope.find(params[:id])
    else
      brand_scope.new
    end
  end

  def save_brand!
    brand.attributes = brand_params
    brand.save!
  end

  def brand_scope
    Brand.all
  end

  def brand_params
    if params[:brand].present?
      params.require(:brand).permit(:name)
    else
      {}
    end
  end
end
