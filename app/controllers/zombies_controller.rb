class ZombiesController < ApplicationController
  def new
    @zombie = Zombie.new
  end

  def create
    @zombie = Zombie.create(params[:zombie])
    redirect_to zombies_path, :notice=>"Added Zombie"
  end

  def index
    @zombies = Zombie.order(:name)
  end

  def show
    @zombie = Zombie.find(params[:id])
  end

  def edit
    @zombie = Zombie.find(params[:id])
  end

  def update
    @zombie = Zombie.find(params[:id])
    @zombie.update_attributes(params[:zombie])
    redirect_to edit_zombie_path(@zombie), :notice=>"Zombie saved at #{Time.now.strftime("%H:%M")}"
  end
end
