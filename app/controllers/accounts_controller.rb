class AccountsController < ApplicationController
    before_action :authenticate_user
    before_action :logged_in?
    before_action :find_account, only: [:show, :edit, :update, :destroy]

    def index
        @accounts = current_user.accounts.order_by_amount
    end
    
    def new
      if @current_user
         @account = Account.new 
      else
        redirect_to '/signin'
        flash[:error] = "sign in first to create a new account"
      end
    end

    def create
        @account = current_user.accounts.new(account_params)
        if @account.save
            redirect_to account_path(@account)  #account_show page
            flash[:notice] = "Successfully Created An Account"
        else
            render 'new' #accounts new form 
        end
   end  

   def show
      if @account.user == current_user
        render 'show' #account show page
      else
        redirect_to accounts_path
        flash[:error] = "you are unauthorized to view this page"
      end
   end

   def edit 
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
