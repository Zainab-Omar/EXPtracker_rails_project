class ExpensesController < ApplicationController
    before_action :logged_in?
    before_action :find_account

    def index
        @expenses = Expense.all
    end

    def new
        @account = current_user.accounts.find_by(id: params[:account_id])
            if @account
              @expense = @account.expenses.new
            else
              redirect_to accounts_path
            end
          end
    #    if logged_in?
    #       @expense = Expense.new
    #     else
    #         redirect_to '/'
    #     end 

    def create
      # raise params.inspect
      # @account = current_user.accounts.find_by(id: params[:account_id]) #find parent route
      # binding.pry
       @expense = @account.expenses.build(expense_params)
       @expense.user_id = current_user.id
       if @expense.save
         flash[:notice] = "Successfully Created An Expense"
         redirect_to account_expense_path(@account, @expense) #account/expense/showpage
      else
        render 'new'
     end
   end

   def show
    if @account.nil?
      redirect_to accounts_path #account index page
      flash[:error] = "Account Not Found"
    else
      @expense = @account.expenses.find_by(id: params[:id])
      # binding.pry
      if @expense.nil?
        redirect_to account_path(@account) #account show page
        flash[:error] = "Expense Not Found"
      end
       end
  end

  private
    def expense_params
      params.require(:expense).permit(:amount, :description, :date, :user_id, :account_id, :category_name)
    end

   def find_account
      @account = Account.find_by(id: params[:account_id])
   end
end
