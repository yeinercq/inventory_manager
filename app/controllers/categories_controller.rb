class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = current_company.categories.all
  end

  def new
    @category = current_company.categories.build
  end

  def create
    @category = current_company.categories.build(category_params)
    if @category.save
      redirect_to categories_path, notice: t('categories.created_success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: t('categories.updated_success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: t('categories.destroyed_success')
  end

  private

  def set_category
    @category = current_company.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
