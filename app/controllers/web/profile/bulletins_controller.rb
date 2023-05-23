# frozen_string_literal: true

class Web::Profile::BulletinsController < Web::Profile::ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.where(user: current_user).order(created_at: :desc).page(params[:page])
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    @bulletin = current_user.bulletins.build
    authorize @bulletin
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    authorize @bulletin
    if @bulletin.save
      redirect_to profile_root_path, notice: t('.bulletin_created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
    if @bulletin.update(bulletin_params)
      redirect_to profile_bulletin_path(@bulletin), notice: t('.bulletin_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def to_moderation
    bulletin = Bulletin.find(params[:id])
    authorize bulletin
    bulletin.to_moderation!
    redirect_to profile_root_path, notice: t('.sent_to_moderation')
  end

  def to_archive
    bulletin = Bulletin.find(params[:id])
    authorize bulletin
    bulletin.to_archive!
    redirect_to profile_root_path, notice: t('.sent_to_archive')
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
