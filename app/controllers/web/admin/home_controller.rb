# frozen_string_literal: true

class Web::Admin::HomeController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc)

    # @bulletins = Bulletin.order(created_at: :desc)
    authorize Bulletin
  end
end
