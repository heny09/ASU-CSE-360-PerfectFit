class ProfilesController < ApplicationController
  #before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_filter :authorize, only: [:show_profile, :edit_profile, :update]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
    @user_id = current_user
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @user_id = current_user
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @current_user.profile.update(profile_params)
        format.html { redirect_to '/show_profile', notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: '/edit_profile' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :no_content }
    end
  end

  def show_profile
    @user = current_user
    @profile = @user.profile
    @profile.age = user_age

  end

  def edit_profile
    @user = current_user
    @profile = @user.profile
    @profile.age = user_age


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :age, :gender, :weight, :zipcode, :birthday, :user_id, :time_zone, :inches, :feet, :height)
    end
end
