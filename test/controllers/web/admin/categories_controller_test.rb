# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    sign_in users(:admin)
    @category = categories(:one)
    @category_params = { name: 'test' }
  end

  test 'should get index' do
    get admin_categories_path
    assert_response :success
  end

  test 'should get new' do
    get new_admin_category_path
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_category_path(@category)
    assert_response :success
  end

  test 'should create category' do
    post admin_categories_path params: { category: @category_params }
    assert { Category.exists?(name: @category_params[:name]) }
    assert_redirected_to admin_categories_path
  end

  test 'should update category' do
    patch admin_category_path(@category), params: { category: @category_params }
    @category.reload
    assert { @category.name == @category_params[:name] }
    assert_redirected_to admin_categories_path
  end

  test 'should destroy category' do
    id = @category.id
    delete admin_category_path @category
    assert { Category.where(id:).empty? }
    assert_redirected_to admin_categories_path
  end
end
