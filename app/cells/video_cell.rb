class VideoCell < Cell::Base
  def videos
    @videos = @opts[:videos]
    @hide_thumbnail = @opts[:hide_thumbnail] === true;
    @hide_description = @opts[:hide_description] === true;
    @css_class = @opts[:css_class] || 'videos'
    
    view = (@opts[:style] || :div).to_sym
    view = :div unless [:section, :list].include?(view)

    render :view => "videos_#{view}"
  end
end
