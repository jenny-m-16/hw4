class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["username"]}"
        redirect_to "/places"
      else
        flash["notice"] = "Your password is incorrect. Try again."
        redirect_to "/login"
      end
    else
      flash["notice"] = "This email account does not exist. Please sign-up."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Thanks for stopping by! Come back soon."
    redirect_to "/login"
  end
end
  