class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenitcate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to :root
    else
      redirect_to '/sessions/new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
