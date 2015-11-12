class SessionsController < ApplicationController
  def new
  end 
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] =  "　#{@user.name}　#{t('controller.Logged in as')} "
      redirect_to @user
    else
      flash[:danger] = t('controller.invalid email/password combination')
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path , notice: t('controller.setting profile')
    else
      render 'edit'
    end
  end
end
