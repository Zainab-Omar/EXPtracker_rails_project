class AccountsController < ApplicationController

    def index
        @accounts = Account.all
    end
    
    def new
        if logged_in?
            @account = Account.new
        else
            redirect_to '/'
        end   
    end

    def create
        #raise params.inspect
        #binding.pry
        if logged_in?
        @account = Account.new(account_params)
        @user = current_user
        @account.user_id = @user.id
        if @account.save
            flash[:notice] = "Successfully Created An Account"
            redirect_to accounts_path  #account_index page
        else
            redirect_to new_account_path #accounts new form 
        end
      end
   end  

   def show
    if logged_in?
        @account = Account.find_by(id: params[:id])
    end
   end

    private

    def account_params
      params.require(:account).permit(:name, :amount, :user_id)  
    end

    def find_account
        @account = Account.find_by(id: params[:id])
    end
end
