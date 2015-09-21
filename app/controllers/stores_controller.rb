class StoresController < ApplicationController
  def index
    render locals: { stores: stores }
  end

  def new
    render locals: { store: store }
  end

  def create
    save_store!
    redirect_to stores_url
  rescue ActiveRecord::RecordInvalid => e
    render :new, locals: { store: e.record }
  end

  def edit
    render locals: { store: store }
  end

  def update
    save_store!
    redirect_to stores_url
  rescue ActiveRecord::RecordInvalid => e
    render :edit, locals: { store: e.record }
  end

  def destroy
    store.destroy!
    respond_to do |format|
      format.js { render locals: { store: store } }
      format.html { redirect_to stores_url }
    end
  end

  private

  def stores
    @stores ||= store_scope.ordered_by_name
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
