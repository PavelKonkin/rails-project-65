# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @bulletin_draft = bulletins(:one)
    @bulletin_under_moderation = bulletins(:two)
    sign_in users(:admin)
  end

  test 'should get index' do
    get admin_root_path
    assert_response :success
  end

  test 'should get show' do
    get bulletin_url(@bulletin_draft)
    assert_response :success
  end

  test 'should make transition to publish from under_moderation' do
    patch publish_admin_bulletin_path(@bulletin_under_moderation)
    @bulletin_under_moderation.reload
    assert { @bulletin_under_moderation.published? }
    assert_redirected_to admin_root_url
  end

  test 'should make transition to reject publish from under_moderation' do
    patch reject_admin_bulletin_path(@bulletin_under_moderation)
    @bulletin_under_moderation.reload
    assert { @bulletin_under_moderation.rejected? }
    assert_redirected_to admin_root_url
  end

  test 'should make transition to archived from under_moderation' do
    patch archive_admin_bulletin_path(@bulletin_under_moderation)
    @bulletin_under_moderation.reload
    assert { @bulletin_under_moderation.archived? }
    assert_redirected_to admin_root_url
  end

  test 'should not make transition to published from draft' do
    patch publish_admin_bulletin_path(@bulletin_draft)
    @bulletin_draft.reload
    assert { @bulletin_draft.draft? }
    assert_redirected_to admin_root_url
  end
end
