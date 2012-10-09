class ZombiesController < ApplicationController
  def new
    @zombie = Zombie.new
  end

  def create
    @zombie = Zombie.create(params[:zombie])
    @zombie.avatar = params[:zombie][:avatar] if params[:zombie][:avatar].present? rescue nil
    @zombie.save!
    redirect_to zombies_path, :notice=>"Added Zombie"
  end

  def index
    @zombies = Zombie.order(:name)
  end

  def show
    @zombie = Zombie.find(params[:id])
    @tweets = @zombie.tweets
    @tweet = Tweet.new
    @tweet.zombie = @zombie
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @zombie }
      format.xml  { render xml: @zombie }
    end
  end

  def edit
    @zombie = Zombie.find(params[:id])
  end

  def update
    @zombie = Zombie.find(params[:id])
    @zombie.update_attributes(params[:zombie])
    @zombie.avatar = params[:zombie][:avatar] if params[:zombie][:avatar].present? rescue nil
    @zombie.save!
    redirect_to edit_zombie_path(@zombie), :notice=>"Zombie saved at #{Time.now.strftime("%H:%M")}"
  end
end
