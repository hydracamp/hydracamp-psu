class ZombiesController < ApplicationController
  def new
    @zombie = Zombie.new
  end
  
  def destroy    
    Zombie.destroy(params[:id])
    redirect_to zombies_path
  end

  def create
    @zombie = Zombie.create(params[:zombie])
    @zombie.avatar = params[:zombie][:avatar] if params[:zombie][:avatar].present? rescue nil
    @zombie.save!
    current_archivist.inc_points 50
    redirect_to zombies_path, :notice=>"Added Zombie"
  end

  def index
    @zombies = Zombie.find(:all,:sort=>"name_sort desc")
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
    @zombies = Zombie.find(:all,:sort=>"name_sort desc").reject{|z| z==@zombie}.map{|z| [ z.name, z.id ]}
  end

  def update
    @zombie = Zombie.find(params[:id])
    @zombie.update_attributes(params[:zombie])
    @zombie.avatar = params[:zombie][:avatar] if params[:zombie][:avatar].present? rescue nil
    @zombie.save!
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

  def history
    @zombie = Zombie.find(params[:id])
  end

end
