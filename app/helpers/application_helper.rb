module ApplicationHelper
  def calculate_total_amount(category)
    category.expenses.sum(:amount)
  end
end
