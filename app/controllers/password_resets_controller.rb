class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      # Send Email
      PasswordMailer.with(user: @user).reset.deliver_now
    end

    redirect_to root_path, notice: "If an account with that email was found, we have sent a link to reset your password."
  end

  def edit
    # Try to find user from signed token, or rescue if token is invalid/expired
    @user = User.find_signed!(params[:token], purpose: :password_reset)
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_in_path, alert: "Your password reset link has expired. Please request a new one."
  end

  def update
    @user = User.find_signed!(params[:token], purpose: :password_reset)
    if @user.update(password_params)
      redirect_to sign_in_path, notice: "Password reset successfully. Please sign in."
    else
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_in_path, alert: "Your password reset link has expired. Please request a new one."
  end



  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
