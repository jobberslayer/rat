class Admin::UsersController < ApplicationController
  def show
    @users = User.find(:all, order: "last_name, first_name")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to admin_show_users_path, notice: "New user #{@user.full_name} created."
    else
      admin_new_user_path
    end
    
  end

  def edit
  end

  def update
  end

  def delete
  end
end
