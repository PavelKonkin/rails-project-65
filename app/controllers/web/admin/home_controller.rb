# frozen_string_literal: true

class Web::Admin::HomeController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.order(created_at: :desc)
    authorize Bulletin
  end
end
