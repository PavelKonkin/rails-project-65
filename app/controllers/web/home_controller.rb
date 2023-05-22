# frozen_string_literal: true

class Web::HomeController < Web::ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.published.order(created_at: :desc)
  end
end
