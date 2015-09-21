require 'test_helper'

class StoresControllerTest < ActionController::TestCase
  def test_index
    get :index

    assert_response :success
    assert_template :index
  end

  def test_new
    get :new

    assert_response :success
    assert_template :new
  end

  def test_create
    assert_difference 'Store.count' do
      post :create, store: { name: generate(:string) }
    end
    assert_redirected_to stores_path
  end

  def test_edit
    store = create(:store)
    get :edit, id: store

    assert_response :success
    assert_template :edit
  end

  def test_update
    store = create(:store)
    get :update, id: store, store: {}

    assert_redirected_to stores_path
  end

  def test_destroy
    store = create(:store)

    assert_difference 'Store.count', -1 do
      delete :destroy, id: store
    end
    assert_redirected_to stores_path
  end
end
