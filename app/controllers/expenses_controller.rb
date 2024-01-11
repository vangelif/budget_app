class ExpensesController < ApplicationController
  def index
    @expenses = current_user.expenses
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = current_user.expenses.build(expense_params)

    if @expense.save
      category_ids = params[:expense][:category_ids].reject(&:empty?)
      category = Category.find(category_ids.first) if category_ids.any?
      redirect_to category_path(category), notice: 'Expense successfully created!'
    else
      render 'new'
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    category = @expense.category_ids
    @expense.destroy
    redirect_to category_path(category), notice: 'Expense successfully deleted!'
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, category_ids: [])
  end
end
