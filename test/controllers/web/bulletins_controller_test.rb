# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @bulletin = bulletins(:one)
    sign_in users(:one)
    @image = fixture_file_upload('one.jpg', 'image/jpeg')
  end

  test 'should get index' do
    get bulletins_path
    assert_response :success
  end

  test 'should get show' do
    get bulletin_url(@bulletin)
    assert_response :success
  end

  test 'should get new' do
    get new_bulletin_url
    assert_response :success
  end

  test 'should get create' do
    post bulletins_url, params: { bulletin: { title: @bulletin.title, description: @bulletin.description, user_id: @bulletin.user_id, category_id: @bulletin.category_id, image: @image } }
    assert_response :redirect
  end

  test 'should get edit' do
    get bulletin_url @bulletin
    assert_response :success
  end

  test 'should get update' do
    patch bulletin_url @bulletin
    assert_response :success
  end

  test 'should get destroy' do
    delete bulletin_url @bulletin
    assert_response :success
  end
end
