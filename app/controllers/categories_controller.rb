class CategoriesController < ApplicationController

  before_action :set_category, only: [:show]

  def index
    @categories = Category.is_active.all
  end


  def new
    @category = Category.new
  end


  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @product_type.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end


  def show
    @popular_products = Product.where(category: @category.subtree_ids).popular.is_active.take(5)
    @new_products = Product.where(category: @category.subtree_ids).is_new.is_active.take(5)
    @pagy, @children = pagy(@category.children.popular.is_active.all, items: 5)

    impressionist(@category, "web")
  end


  private

    def category_params
      params.require(:category).permit!
    end

    def set_category
      @category = Category.friendly.find(params[:id])
    end

end
