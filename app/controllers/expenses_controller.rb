class ExpensesController < ApplicationController
    before_action :logged_in?
    before_action :find_account

    def index
     # binding.pry
        if @account.nil?
          redirect_to accounts_path #account index page
          flash[:error] = "Account does not exist"
        elsif
          @account.user_id == current_user.id
          @expenses = @account.expenses
        else
          redirect_to accounts_path
          flash[:error] = "you are unauthorized to view expenses associated with this account"
        end
    end

    def new

    #binding.pry
        #@account = current_user.accounts.find_by(id: params[:account_id])
          if @account && @account.user_id == current_user.id
            @expense = @account.expenses.new
          else
            redirect_to accounts_path
            flash[:error] = "unauthorized to create new expense"
            end
          end

    def create
      # raise params.inspect
      # @account = current_user.accounts.find_by(id: params[:account_id]) #find parent route
      #binding.pry
       @expense = @account.expenses.build(expense_params)
       @expense.user_id = @account.user_id
       if @expense.save
         redirect_to account_expense_path(@account, @expense) #account/expense/showpage
         flash[:notice] = "Successfully Created An Expense"
      else
        render 'new'
     end
   end

   def show

   #binding.pry
    # if @account.nil?
    #   redirect_to accounts_path #account index page
    #   flash[:error] = "Account Not Found"
    # elsif
      if @account && @account.user == current_user
         @expense = @account.expenses.find_by(id: params[:id])
       if @expense.nil?
          redirect_to account_path(@account) #account show page
          flash[:error] = "Expense Not Found"
      else
        render 'show'
      end
    else
        redirect_to accounts_path
        flash[:error] = "unauthorized to view this expense"
     end
    end

    def edit
      #binding.pry
      if @account && @account.user == current_user
          @expense = @account.expenses.find_by(id: params[:id])
      else
        redirect_to account_path(@account)
          #flash[:error] = "Expense not found or You are not authorized to edit it"
        end
    end

    def update
      #binding.pry
      @expense = @account.expenses.find_by(id: params[:id])
      if @expense.update(expense_params)
        redirect_to account_expense_path(@account, @expense)
        flash[:notice] = "Successfully Updated The Expense"
      else
        render 'edit'
      end
    end

    def destroy
     # binding.pry
     @expense = Expense.find_by(id: params[:id])
      if @expense.delete
        redirect_to account_expenses_path(@expense.account, @expense)
        flash[:notice] = "Successfully Deleted an Expense"
      end
    end

    # def most_recent
    #  #binding.pry
    #  @expenses = Expense.recent
    # end

  private
    def expense_params
      params.require(:expense).permit(:amount, :description, :date, :user_id, :account_id, :category_name)
    end

   def find_account
      @account = Account.find_by(id: params[:account_id])
   end
end
