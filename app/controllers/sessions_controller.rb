class SessionsController < ApplicationController
  def create
    user = User.find_by(username: login_params[:username])
    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      render json: { success: true, message: 'login successfully' }, status: :ok
    else
      render json: { success: false, message: 'username or password is incorrect' }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { success: true, message: 'logged out successfully' }, status: :ok
  end

  private

  # Only allow a list of trusted parameters through.
  def login_params
    params.permit(:username, :password)
  end
end
