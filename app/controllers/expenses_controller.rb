class ExpensesController < ApplicationController
    belongs_to :user
    belongs_to :category
    belongs_to :income
end
