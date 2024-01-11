class CategoriesController < ApplicationController
  # before_action :authenticate_user!
  helper_method :calculate_total_amount

  def index
    @categories = current_user.categories
    @total_amount = calculate_total_amount(current_user)
    puts "In the index: #{@total_amount.inspect}"
  end

  def new
    @category = Category.new
    @categories = Category.all
  end

  # /categories/:id
  def show
    @category = Category.find(params[:id])
    @total_amount = calculate_total_amount(@category)
    puts "In the show: #{@total_amount.inspect}"
  end

  def calculate_total_amount(category)
    @total_amount = category.expenses.sum(:amount)
  end

  # /categories POST
  def create
    @category = Category.new(category_params)
    @category.user = current_user

    puts "Before attach: #{category_params.inspect}"

    @category.icon.attach(category_params[:icon]) if category_params[:icon].present?

    puts "After attach: #{@category.inspect}" # Debugging statement

    if @category.save
      redirect_to categories_path, notice: 'Category successfully created!'
    else
      puts @category.errors.full_messages
      render 'new'
    end
  end

  def sign_out
    sign_out(current_user)
    redirect_to root_path, notice: 'Signed out successfully.'
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: 'Category successfully deleted!'
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon) if params[:category].present? # Add any additional attributes
  end
end
