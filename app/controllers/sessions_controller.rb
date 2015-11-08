class SessionsController < ApplicationController
  def new
  end 
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] =  "　#{@user.name}　としてログインしました "
      redirect_to @user
    else
      flash[:danger] = 'メールアドレスとパスワードの組み合わせが違います'
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
      redirect_to root_path , notice: 'プロフィールを編集しました'
    else
      render 'edit'
    end
  end
end
