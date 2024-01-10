class CategoriesController < ApplicationController
  # before_action :authenticate_user!

  def index
    @categories = current_user.categories
  end

  def new
    @category = Category.new
    @categories = Category.all
  end

  # /categories/:id
  def show
    @category = Category.find(params[:id])
  end

  # /categories POST
  def create
    @category = Category.new(category_params)
    @category.user = current_user

    puts "Before attach: #{category_params.inspect}"

    if category_params[:icon].present?
      @category.icon.attach(category_params[:icon])
    end

    puts "After attach: #{@category.inspect}" # Debugging statement
    
    if @category.save
      redirect_to categories_path, notice: "Category successfully created!"
    else
      puts @category.errors.full_messages
      render "new"
    end
  end

  def sign_out
    sign_out(current_user)
    redirect_to root_path, notice: "Signed out successfully."
  end

private
def category_params
  params.require(:category).permit(:name, :icon) if params[:category].present? # Add any additional attributes
end

end
