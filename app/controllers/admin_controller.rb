class AdminController < ApplicationController
  layout 'admin'

  def authenticate
    if (params[:username] == ENV['ADMIN_USERNAME'] and params[:password] == ENV['ADMIN_PASSWORD']) or session[:pass_auth_gate] == 'true'
      session[:pass_auth_gate] = 'true'
    else
      redirect_to root_path
    end
  end

  def index
    if session[:pass_auth_gate] == 'true'
      redirect_to admin_courses_path
    else
      render :layout => 'application'
    end
  end

end
