class SessionsController < ApplicationController

    def new
    end

    def create
        #omniauth login
        if auth
            @user = User.find_or_create_by(uid: auth['uid']) do |u|
                u.username = auth['info']['nickname']
                u.email = auth['info']['email']
                u.password = SecureRandom.hex
            end
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            #normal login 
        @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user) #show page
            flash[:notice] = "Successfully signed in"
        else
           flash[:error] = "Please enter correct email or password"
         render 'new'
        end
      end
    end

    def destroy
        session.delete :user_id
        redirect_to '/signin'
        flash[:notice] = "Successfully Signed out!"
    end

    private
    def auth
        request.env['omniauth.auth']
    end
end
