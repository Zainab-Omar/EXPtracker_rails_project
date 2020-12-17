class SessionsController < ApplicationController

    def new
    end

    def create
        #normal sign in with username and password
        #raise params.inspect
        #binding.pry
        @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user) #show page
            flash[:notice] = "Successfully signed in"
        else
         flash[:error] = "Please enter correct email and password, or sign up"
         redirect_to '/'
        end
    end

    def destroy
        session.delete :user_id
        redirect_to '/signin'
        flash[:notice] = "Successfully Signed out!"
    end
end
