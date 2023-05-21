# frozen_string_literal: true

require 'test_helper'

class Web::Profile::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @bulletin = bulletins(:one)
    @bulletin2 = bulletins(:two)
    @bulletin3 = bulletins(:three)
    sign_in users(:one)
    @image = fixture_file_upload('one.jpg', 'image/jpeg')
    @update_image = fixture_file_upload('three.jpeg', 'image/jpeg')
  end

  test 'should get index' do
    get profile_root_path
    assert_response :success
  end

  test 'should get show' do
    get profile_bulletin_url(@bulletin)
    assert_response :success
  end

  test 'should get new' do
    get new_profile_bulletin_url
    assert_response :success
  end

  test 'should get create' do
    post profile_bulletins_url, params: { bulletin: { title: @bulletin.title, description: @bulletin.description, user_id: @bulletin.user_id, category_id: @bulletin.category_id, image: @image } }
    assert_response :redirect
  end

  test 'should get edit' do
    get edit_profile_bulletin_url @bulletin
    assert_response :success
  end

  test 'should get update' do
    sign_in users(:two)
    patch profile_bulletin_url(@bulletin2), params: { bulletin: { title: @bulletin.title, description: @bulletin.description, user_id: @bulletin2.user_id, category_id: @bulletin.category_id, image: @update_image } }
    assert_response :redirect
  end

  test 'should get transition to under_moderation from draft' do
    patch to_moderation_profile_bulletin_path(@bulletin)
    @bulletin.reload
    assert { @bulletin.under_moderation? }
    assert_redirected_to profile_root_url
  end

  test 'should get transition to archived from draft' do
    patch to_archive_profile_bulletin_path(@bulletin)
    @bulletin.reload
    assert { @bulletin.archived? }
    assert_redirected_to profile_root_url
  end

  test 'should not get transition to under_moderation from archive' do
    patch to_moderation_profile_bulletin_path(@bulletin3)
    @bulletin3.reload
    assert { @bulletin3.archived? }
    assert_redirected_to profile_root_url
  end
end
