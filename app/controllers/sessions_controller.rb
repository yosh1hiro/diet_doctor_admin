class SessionsController < ApplicationController
  skip_before_filter :authenticate_user
  skip_before_filter :admin_user

  # GET /sessions/new
  def new
    respond_to do |format|
      format.html
      format.json { head 200 }
    end
  end

  # POST /sessions
  def create
    user = User.authenticated_user(params.permit(:name, :password))
    if user
      session[:user_id] = user.id
      cookies.permanent.signed[:user_id] = user.id
      cookies.permanent.signed[:auto_login_token] = user.auto_login_token unless /^admin\./ =~ user.name
      flash.notice = 'ログインしました。'
      respond_to do |format|
        format.html   { redirect_to :root }
        format.json   { head 200 }
      end
    else
      flash.alert = 'ログイン名またはパスワードが正しくありません。'
      respond_to do |format|
        format.html   { redirect_to :root }
        format.json   { head 401 }
      end
    end
  end

  # DELETE /sessions/:id
  def destroy
    session.delete :user_id
    cookies.delete :user_id
    cookies.delete :auto_login_token
    respond_to do |format|
      format.html   { redirect_to :root, :notice => 'ログアウトしました。' }
      format.json   { head :no_content }
    end
  end
end
