class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenitcate_with_credentials(params['/sessions'][:email], params['/sessions'][:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:error] = 'An error occured!'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
