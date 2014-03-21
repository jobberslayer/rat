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
      render admin_new_user_path
    end
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_without_password(params[:user])

    if @user.save
      redirect_to admin_show_users_path, notice: "User #{@user.full_name} updated."
    else
      render 'edit' 
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.tasks.exists? || @user.statuses.exists?
      flash[:alert] = "#{@user.full_name} still has tasks or updates assigned to them. " +
          "Reassign them to another user and then try to delete again."
      redirect_to admin_show_users_path
    else
      @user.destroy
      redirect_to admin_show_users_path 
    end

  end

  def toogle_locking
    @user = User.find(params[:id])
    condition = '';
    if @user.access_locked?
      @user.unlock_access!
      condition = 'unlocked'
    else
      @user.lock_access!
      condition = 'locked'
    end
    @user.save

    flash[:notice] = "#{@user.full_name} is #{condition}"
    redirect_to admin_show_users_path
  end
end
