class CategoriesController < ApplicationController
  def index
    render locals: { categories: categories }
  end

  def new
    render locals: { category: category }
  end

  def create
    save_category!
    redirect_to categories_url
  rescue ActiveRecord::RecordInvalid => e
    render :new, locals: { category: e.record }
  end

  def edit
    render locals: { category: category }
  end

  def update
    save_category!
    redirect_to categories_url
  rescue ActiveRecord::RecordInvalid => e
    render :edit, locals: { category: e.record }
  end

  def destroy
    category.destroy!
    redirect_to categories_url
  end

  private

  def categories
    @categories ||= category_scope.all
  end

  def category
    @category ||= if params[:id].present?
      category_scope.find(params[:id])
    else
      category_scope.new
    end
  end

  def save_category!
    category.attributes = category_params
    category.save!
  end

  def category_scope
    Category.all
  end

  def category_params
    if params[:category].present?
      params.require(:category).permit(:name)
    else
      {}
    end
  end
end
