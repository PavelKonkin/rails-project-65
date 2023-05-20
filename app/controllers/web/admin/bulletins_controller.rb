# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.order(created_at: :desc)
    authorize @bulletins
  end

  def show
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end
end
