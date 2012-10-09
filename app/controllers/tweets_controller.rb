class TweetsController < ApplicationController
  # create
  def create
    zombie_id = params[:tweet].delete(:zombie_id)
    @tweet = Tweet.new(params[:tweet])
    @tweet.zombie_id = zombie_id
    @tweet.save!
    redirect_to zombie_path(@tweet.zombie), :notice=>"Tweet Added"
  end
  
  def update
    tweet = Tweet.find(params[:id])
    tweet.rating += 1
    tweet.save!
    redirect_to zombie_path(tweet.zombie), :notice=>"Tweet Liked"
  end

  def index
    @tweets = Tweet.all
  end
  
  def destroy
    coin = rand(2)
    if coin == 1
      @tweet = Tweet.destroy(params[:id])
    else
      @tweet = Tweet.find(params[:id])
      @tweet = @tweet.update_attributes(:message => @tweet.message.split.shuffle.join(" "))
    end
    redirect_to tweets_path, :notice=>"The Tweet is gone, or is it..."
  end
  
end
