class AccountsController < ApplicationController
    before_action :authenticate_user
    before_action :find_account, only: [:show, :edit, :update, :destroy]

    def index
        @accounts = Account.all
    end
    
    def new
     @account = Account.new 
    end

    def create
        #raise params.inspect
        #binding.pry
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

   def show
        if @account.nil?
            redirect_to accounts_path
        end
   end

   def edit 
   # binding.pry
    if @account.nil?
        redirect_to accounts_path #account index page
        flash[:error] = "Account Can not be Found" 
    end
   end

   def update
    #binding.pry
    if @account.update(account_params)
        flash[:notice] = "Successfully Updated Account"
        redirect_to account_path(@account)
    else
        render 'edit'
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
