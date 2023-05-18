# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  def index
    @bulletins = Bulletin.order(created_at: :desc)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    @bulletin = current_user.bulletins.build
  end

  def edit; end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    if @bulletin.save
      redirect_to root_path, notice: t('.bulletin_created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update; end

  def destroy; end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
