class BrandsController < ApplicationController
  def index
    render locals: { brands: brands }
  end

  def new
    render locals: { brand: brand }
  end

  def create
    save_brand!
    redirect_to brands_url, notice: 'Бренд успешно добавлен.'
  rescue ActiveRecord::RecordInvalid => e
    render :new, locals: { brand: e.record }
  end

  def edit
    render locals: { brand: brand }
  end

  def update
    save_brand!
    redirect_to brands_url, notice: 'Бренд успешно изменен.'
  rescue ActiveRecord::RecordInvalid => e
    render :edit, locals: { brand: e.record }
  end

  def destroy
    brand.destroy!
    flash.now[:notice] = 'Бренд удален.'
  rescue ActiveRecord::DeleteRestrictionError => e
    flash.now[:alert] = 'Не удается удалить бренд.'
  ensure
    respond_to do |format|
      format.js { render 'shared/destroy', locals: { model: brand } }
      format.html { redirect_to brands_url }
    end
  end

  private

  def brands
    @brands ||= brand_scope.ordered_by_name.page(params[:page])
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
