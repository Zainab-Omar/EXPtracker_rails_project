class UsersController < ApplicationController
 
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
         if @user.valid?
          @user.save
          flash[:notice] = "Successfully Created An Account"
          session[:user_id] = @user.id
          redirect_to user_path(@user) #user showpage 
        else
          render 'new' #show the sign up form
        end
      end

    def show
        @user = User.find_by(id: params[:id])
        if @user == current_user
          @accounts  = @user.accounts
        else
          redirect_to '/'
          flash[:error] = "can not access other users pages"
      end
    end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
