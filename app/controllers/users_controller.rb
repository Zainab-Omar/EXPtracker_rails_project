class UsersController < ApplicationController
    has_many :expenses
    has_many :incomes
    has_many :categories, through: :expenses
end
