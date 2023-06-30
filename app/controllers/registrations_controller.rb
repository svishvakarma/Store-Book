class RegistrationsController < DeviseTokenAuth::ApplicationController
  before_action :authenticate_user!, except: :create
  protect_from_forgery with: :null_session

  def create
    byebug
    user = User.new(sign_up_params)
    if user.save
      render json: { email: user.email,
                     message: 'Sign Up Successful' }, status: :ok
    else
      render json: { errors: user.errors.full_messages, status: :unprocessable_entity }
    end
  end

  private

  def sign_up_params
    params.permit(:name, :nickname, :email, :password, :password_confirmation)
  end
end
