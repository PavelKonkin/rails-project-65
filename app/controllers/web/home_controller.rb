# frozen_string_literal: true

class Web::HomeController < Web::ApplicationController
  def index
    @bulletins = Bulletin.published.order(created_at: :desc)
  end
end
