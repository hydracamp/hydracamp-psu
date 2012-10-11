class ZombiesController < ApplicationController

  def new
    @zombie = Zombie.new
  end
  
  def destroy    
    Zombie.destroy(params[:id])
    redirect_to zombies_path
  end

  def create
    params[:zombie].delete(:avatar)
    @zombie = Zombie.create(params[:zombie])
    #@zombie.avatar = params[:zombie][:avatar] if params[:zombie][:avatar].present? rescue nil
    if @zombie.save
      current_archivist.inc_points 50
      redirect_to zombies_path, :notice=>"Added Zombie"
    else
      flash[:notice] = @zombie.errors.full_messages.join(".<br/>").html_safe
      render :new
    end
  end

  def index
    @zombies = Zombie.find(:all,:sort=>"name_sort asc")
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
    if @zombie.save
      msg = "Zombie saved at #{Time.now.strftime("%H:%M")}"
      redirect_to edit_zombie_path(@zombie), :notice => msg
    else
      flash[:notice] = @zombie.errors.full_messages.join(".<br/>").html_safe
      render :edit
    end
  end

  # def search
  #   @q = params[:q]

  #   q_delimited_by_space = @q.split(' ')

  #   generated_like_clause = []
  #   args = []
  #   q_delimited_by_space.each do |word|
  #     generated_like_clause << "name LIKE ? OR nickname LIKE ? OR description LIKE ? OR graveyard LIKE ?"
  #     args << "%#{word}%" << "%#{word}%" << "%#{word}%" << "%#{word}%"
  #   end

  #   #Convert generated_like_clause from array to string, using ' OR ' delimiter
  #   generated_like_clause = generated_like_clause.join(' OR ')

  #   @zombies = Zombie.where(generated_like_clause, *args )
  # end

  def history
    @zombie = Zombie.find(params[:id])
  end

end
