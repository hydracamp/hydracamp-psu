class ZombiesController < ApplicationController
  def new
    @zombie = Zombie.new
  end

  def create
    @zombie = Zombie.create(params[:zombie])
    current_archivist.inc_points 50
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
    redirect_to edit_zombie_path(@zombie), :notice=>"Zombie saved at #{Time.now.strftime("%H:%M")}"
  end

  def search
    @q = params[:q]

    q_delimited_by_space = @q.split(' ')

    generated_like_clause = []
    args = []
    q_delimited_by_space.each do |word|
      generated_like_clause << "name LIKE ? OR nickname LIKE ? OR description LIKE ? OR graveyard LIKE ?"
      args << "%#{word}%" << "%#{word}%" << "%#{word}%" << "%#{word}%"
    end

    #Convert generated_like_clause from array to string, using ' OR ' delimiter
    generated_like_clause = generated_like_clause.join(' OR ')

    @zombies = Zombie.where(generated_like_clause, *args )
  end

end
