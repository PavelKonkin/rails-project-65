# frozen_string_literal: true

require 'test_helper'

class Web::ProfileControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get profile_path
    assert_response :redirect
  end
end
