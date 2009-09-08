module HomePresenters
  class ShowPresenter
    def top_videos
      @top_videos ||= Video.top.all(:limit => 10)
    end

    def categories
      @categories ||= Category.all(:order => 'name DESC')
    end
    
    def featured_videos
      @featured_videos ||= Video.featured.all(:limit => 5)
    end

    def latest_videos
      @latest_videos ||= Video.latest.all(:limit => 5)
    end
  end
end
