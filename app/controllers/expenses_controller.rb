class ExpensesController < ApplicationController

    def index
        @expenses = Expense.all
    end

    def new
        if logged_in?
        @expense = Expense.new
        end
    end
  
end
