class RegistrationsController < DeviseTokenAuth::ApplicationController
  before_action :authenticate_user!, except: :create
  
  def create
    user = User.new(sign_up_params)
    if user.admin = params[:admin].to_s.downcase == 'true'
      byebug
      user.admin = true
    else
      byebug
      user.admin = false
    end

    if user.save
      render json: { email: user.email,admin: user.admin,
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

