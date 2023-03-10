class SessionsController < ApplicationController
  def new
  end

  def create
    user_params = params.require(:session)

    user = User.find_by(email: user_params[:email])
    user&.authenticate(user_params[:password])

    if user.present?
      session[:user_id] = response.body

      redirect_to root_path, notice: 'Вы вошли на сайт'
    else
      flash.now[:alert] = 'Неправельный email или пароль'

      render :new
    end
  end

  def destroy
    session.delete(:user_id)

    redirect_to root_path, notice: 'Сессия прервана'
  end
end
