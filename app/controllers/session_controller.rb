class SessionController < ApplicationController

  def new
    respond_to do |format|
      format.html
      format.json { head 200 }
    end
  end

  def create
    user = User.authenticated_user(params.require(:user).permit(:name, :password))
    if user
      session[:user_id] = user.id
      # flash.notice = 'ログインしました。'
      respond_to do |format|
        format.html   { redirect_to :root }
        format.json   { head 200 }
      end
    else
      # flash.alert = 'ログイン名またはパスワードが正しくありません。'
      respond_to do |format|
        format.html   { redirect_to :root }
        format.json   { head 401 }
      end
    end
  end

  def destroy
    session.delete :user_id
    cookies.delete :user_id
    respond_to do |format|
      format.html   { redirect_to :root, :notice => 'ログアウトしました。' }
      format.json   { head :no_content }
    end
  end
end
