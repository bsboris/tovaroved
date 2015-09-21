require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
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
    assert_difference 'Product.count' do
      post :create, product: { name: generate(:string), category_id: create(:category), brand_id: create(:brand) }
    end
    assert_redirected_to products_path
  end

  def test_edit
    product = create(:product)
    get :edit, id: product

    assert_response :success
    assert_template :edit
  end

  def test_update
    product = create(:product)
    get :update, id: product, product: {}

    assert_redirected_to products_path
  end

  def test_destroy
    product = create(:product)

    assert_difference 'Product.count', -1 do
      delete :destroy, id: product
    end
    assert_redirected_to products_path
  end
end
