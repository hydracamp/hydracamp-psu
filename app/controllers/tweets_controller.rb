class TweetsController < ApplicationController
  # create
  def create
    zombie_id = params[:tweet].delete(:zombie_id)
    @tweet = Tweet.new(params[:tweet])
    @tweet.zombie_id = zombie_id
    @tweet.save!
    redirect_to zombie_path(@tweet.zombie), :notice=>"Tweet Added"
  end
  
  def index
    @tweets = Tweet.all
  end
end
