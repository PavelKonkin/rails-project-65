# frozen_string_literal: true

require 'test_helper'

class Web::SessionControllerTest < ActionDispatch::IntegrationTest
  def setup
    sign_in users(:one)
  end

  test 'should sign_out' do
    get sessions_path
    assert { session[:user_id].nil? }
    assert_redirected_to root_path
  end
end
