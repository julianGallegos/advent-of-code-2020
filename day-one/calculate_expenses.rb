require 'pry'
require 'sorbet-runtime'

# typed: true
extend T::Sig

sig { params(expenses: Array).returns(Integer) }
def calculate_expenses(expenses)
  target_sum = 2020
  found_expenses = []

  expenses.each do |current_expense|
    target = target_sum - current_expense
    
    if expenses.include?(target) && found_expenses.empty?
      found_expenses << target
      found_expenses << current_expense
    end
  end

  found_expenses.inject(:*)
end
