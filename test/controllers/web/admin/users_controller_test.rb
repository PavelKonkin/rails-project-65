# frozen_string_literal: true

require 'test_helper'

class Web::Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    sign_in users(:admin)
    @user = users(:one)
  end

  test 'should get index' do
    get admin_users_path
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_user_path(@user)
    assert_response :success
  end

  test 'should update user' do
    patch admin_user_path(@user), params: { user: { name: 'test' } }
    @user.reload
    assert { @user.name == 'test' }
    assert_redirected_to admin_users_path
  end
end
