# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.order(id: :desc)
    authorize @categories
  end

  def new
    @category = Category.new
    authorize @category
  end

  def edit
    @category = Category.find(params[:id])
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category
    if @category.save
      redirect_to admin_categories_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find(params[:id])
    authorize @category
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    authorize @category
    @category.destroy
    redirect_to admin_categories_path, notice: t('.deleted')
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
