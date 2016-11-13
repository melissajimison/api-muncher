class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :login]

  def index
  
  end

  def login
  end

  def create
    unless auth_hash
      flash[:notice] = "Login failed!"
      return redirect_to index_path
    end

    # find the person in the database, if the person is new from the site, build the new user and save the user.
    @user = User.find_by(uid: auth_hash[:uid], provider: auth_hash[:provider])
    if @user.nil?
      # User doesn't match anything in the DB.
      # Attempt to create a new user.
      @user = User.build_from_google(auth_hash)
      flash[:notice] = "Unable to Save the User"
      return redirect_to root_path unless @user.save
    end

    # Save the user ID in the session
    # This is the user.id on the local database, NOT the uid that github gives us
    session[:user_id] = @user.id

    flash[:notice] = "Successfully Logged in!"
    redirect_to index_path
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Successfully Logged out!"
    redirect_to index_path
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end

end
