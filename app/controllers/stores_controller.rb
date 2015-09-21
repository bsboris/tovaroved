class StoresController < ApplicationController
  def index
    render locals: { stores: stores }
  end

  def new
    render locals: { store: store }
  end

  def create
    save_store!
    redirect_to stores_url, notice: 'Магазин успешно добавлен.'
  rescue ActiveRecord::RecordInvalid => e
    render :new, locals: { store: e.record }
  end

  def edit
    render locals: { store: store }
  end

  def update
    save_store!
    redirect_to stores_url, notice: 'Магазин успешно изменен.'
  rescue ActiveRecord::RecordInvalid => e
    render :edit, locals: { store: e.record }
  end

  def destroy
    store.destroy!
    flash.now[:notice] = 'Магазин удален.'
  rescue ActiveRecord::DeleteRestrictionError => e
    flash.now[:alert] = 'Не удается удалить магазин.'
  ensure
    respond_to do |format|
      format.js { render 'shared/destroy', locals: { model: store } }
      format.html { redirect_to stores_url }
    end
  end

  private

  def stores
    @stores ||= store_scope.ordered_by_name.page(params[:page])
  end

  def store
    @store ||= if params[:id].present?
      store_scope.find(params[:id])
    else
      store_scope.new
    end
  end

  def save_store!
    store.attributes = store_params
    store.save!
  end

  def store_scope
    Store.all
  end

  def store_params
    if params[:store].present?
      params.require(:store).permit(:name)
    else
      {}
    end
  end
end
