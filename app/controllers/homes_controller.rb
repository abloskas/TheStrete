class HomesController < ApplicationController
    def index
      @homes = Community.order('created_at').limit(3)
      render layout: "index_general"
    end
  
    def show
      @home = Community.all
      render layout: "show_homes"
    end
  
    def map
      render layout: "map_general"
    end
  
    def likes
      Like.create(user:current_user, community:Community.find(params[:community_id]))
      redirect_to "/homes/show"
    end
  
    def destroy
      p "1================="
      p (params[:id])
      p Community.find(params[:id])
      @like = Like.find_by(user:current_user, community:Community.find(params[:id]))
      @like.destroy if @like
      redirect_to '/homes/show'
    end
  end
  
  