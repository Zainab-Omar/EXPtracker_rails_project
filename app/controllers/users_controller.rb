class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)  
          if !@user.save
            render :new
          else
            flash[:notice] = "Successfully Created An Account"
            session[:user_id] = @user.id
            redirect_to user_path(@user)
          end
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

end
