class HomeController < ApplicationController
  def show
    unless fragment_exist?('home/top_videos')
      @top_videos = Video.top.all(:limit => 10)
    end
    
    unless fragment_exist?('home/categories')
      @categories = Category.all(:order => 'name DESC')
    end
    
    unless fragment_exist?('home/featured_videos')
      @featured_videos = Video.featured.all(:limit => 5)
    end

    unless fragment_exist?('home/latest_videos')
      @latest_videos = Video.latest.all(:limit => 5)
    end
  end
end
