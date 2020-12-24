class ApplicationController < ActionController::Base

    def home
        if logged_in?
            redirect_to user_path(current_user) #user show page
        end
    end

    def current_user 
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    def logged_in?
        !!current_user
    end

    # def authenticate_user
    #     if !logged_in?
    #       redirect_to '/'
    #     end
    #   end
end
