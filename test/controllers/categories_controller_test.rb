require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
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
    assert_difference 'Category.count' do
      post :create, category: { name: generate(:string) }
    end
    assert_redirected_to categories_path
  end

  def test_edit
    category = create(:category)
    get :edit, id: category

    assert_response :success
    assert_template :edit
  end

  def test_update
    category = create(:category)
    get :update, id: category, category: {}

    assert_redirected_to categories_path
  end

  def test_destroy
    category = create(:category)

    assert_difference 'Category.count', -1 do
      delete :destroy, id: category
    end
    assert_redirected_to categories_path
  end
end
