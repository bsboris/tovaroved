require 'test_helper'

class BrandsControllerTest < ActionController::TestCase
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
    assert_difference 'Brand.count' do
      post :create, brand: { name: generate(:string) }
    end
    assert_redirected_to brands_path
  end

  def test_edit
    brand = create(:brand)
    get :edit, id: brand

    assert_response :success
    assert_template :edit
  end

  def test_update
    brand = create(:brand)
    get :update, id: brand, brand: {}

    assert_redirected_to brands_path
  end

  def test_destroy
    brand = create(:brand)

    assert_difference 'Brand.count', -1 do
      delete :destroy, id: brand
    end
    assert_redirected_to brands_path
  end
end
