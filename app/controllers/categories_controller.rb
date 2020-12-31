class CategoriesController < ApplicationController
    before_action :authenticate_user
    before_action :logged_in?

    def index
       if params[:q] 
        @categories = current_user.categories.find_by(name: params[:q].titleize)
       else
       @expenses = current_user.expenses
    end
end
   
end
