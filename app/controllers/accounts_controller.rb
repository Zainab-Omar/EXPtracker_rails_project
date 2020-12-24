class AccountsController < ApplicationController
    #before_action :authenticate_user
    before_action :logged_in?
    before_action :find_account, only: [:show, :edit, :update, :destroy]

    def index
        #@accounts = Account.all
        @accounts = current_user.accounts.order_by_amount
    end
    
    def new
     #binding.pry
      if @current_user
         @account = Account.new 
      else
        redirect_to '/signin'
        flash[:error] = "sign in first to create a new account"
      end
    end

    def create
        #raise params.inspect
        #binding.pry
        @account = current_user.accounts.new(account_params)
        #@account.user_id = current_user.id
        if @account.save
            redirect_to accounts_path  #account_index page
            flash[:notice] = "Successfully Created An Account"
        else
            render 'new' #accounts new form 
        end
   end  

   def show
    #binding.pry
    #@account = Account.find_by(id: params[:id])
    if @account.user == current_user
        render 'show' #account show page
    else
        flash[:error] = "you are unauthorized to view this page"
        redirect_to accounts_path
    end
   end

   def edit 
    #binding.pry
    if @account.nil?
        redirect_to accounts_path #account index page
        flash[:error] = "Account Can not be Found" 
    elsif
      @account.user == current_user
      render 'edit'
    else
        redirect_to accounts_path
        flash[:error] = "you are unauthorized to edit this page"
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

   def destroy
    @account.destroy
    flash[:notice] = "Successfully Deleted Account"
    redirect_to accounts_path #account index page
   end

    private

    def account_params
      params.require(:account).permit(:name, :amount, :user_id)  
    end

    def find_account
        @account = Account.find_by(id: params[:id])
    end
end
