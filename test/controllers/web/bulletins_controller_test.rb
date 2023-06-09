# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @bulletin = bulletins(:one)
    sign_in users(:one)
    @image = fixture_file_upload('one.jpg', 'image/jpeg')
    @update_image = fixture_file_upload('three.jpeg', 'image/jpeg')
  end

  test 'should get index' do
    get root_path
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

  test 'should create' do
    post bulletins_url, params: { bulletin: { title: @bulletin.title, description: @bulletin.description, user_id: @bulletin.user_id, category_id: @bulletin.category_id, image: @image } }
    assert_response :redirect
  end

  test 'should edit' do
    get edit_bulletin_url @bulletin
    assert_response :success
  end

  test 'should update' do
    sign_in users(:two)
    @bulletin_to_update = bulletins(:two)
    patch bulletin_url(@bulletin_to_update), params: { bulletin: { title: @bulletin.title, description: @bulletin.description, user_id: @bulletin_to_update.user_id, category_id: @bulletin.category_id, image: @update_image } }
    assert_response :redirect
  end

  test 'should make transition to under_moderation from draft' do
    patch to_moderation_bulletin_path(@bulletin)
    @bulletin.reload
    assert { @bulletin.under_moderation? }
    assert_redirected_to profile_url
  end

  test 'should make transition to archived from draft' do
    patch archive_bulletin_path(@bulletin)
    @bulletin.reload
    assert { @bulletin.archived? }
    assert_redirected_to profile_url
  end

  test 'should not make transition to under_moderation from archive' do
    @bulletin_archived = bulletins(:three)
    patch to_moderation_bulletin_path(@bulletin_archived)
    @bulletin_archived.reload
    assert { @bulletin_archived.archived? }
    assert_redirected_to profile_url
  end
end
