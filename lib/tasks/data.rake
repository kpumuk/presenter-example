namespace :data do
  desc 'Load test videos into the database.'
  task :videos => :environment do
    Video.create(
      :title => 'Learn Excel Episode 1091: Stacked & Clustered',
      :description => 'Jeff from Akron asks how to create a column chart where two series are stacked, but a third series is clustered. Episode 1091 shows you how.',
      :thumbnail_url => 'http://www.bestechvideos.com/thumbnails/0002/4152/7z9cingqpbhjmjrjledwuwhnge_thumb.jpg',
      :views => 10
    )
    
    Video.create(
      :title => 'Learn Excel Episode 1092: Dynamic Chart Arrow',
      :description => 'Craig added an arrow to a line chart. Every time the data changes, the arrow needs to be repositioned. Episode 1092 shows how to add a dynamic XY series to redraw the arrow.',
      :thumbnail_url => 'http://www.bestechvideos.com/thumbnails/0002/4180/7z9cingqpbhjmjrjledwuwhnge_thumb.jpg',
      :views => 405
    )

    Video.create(
      :title => 'Learn Excel Episode 1093: Revenue Bridge Chart',
      :description => 'Mike from Arizona asks how to create a revenue bridge chart. This is similar to a waterfall chart, except some of the points are negative. Episode 1093 will show you how to create this chart.',
      :thumbnail_url => 'http://www.bestechvideos.com/thumbnails/0002/4198/7z9cingqpbhjmjrjledwuwhnge_thumb.jpg',
      :views => 32,
      :featured => true
    )

    Video.create(
      :title => 'Learn Excel Episode 1094: Automatic Freeze Panes',
      :description => 'Excel 2007 offers a cool trick to replace Freeze Panes. Episode 1094 shows you how.',
      :thumbnail_url => 'http://www.bestechvideos.com/thumbnails/0002/4220/c3a8z2refo70y0e13qpwu2vysu_thumb.jpg',
      :views => 101
    )

    Video.create(
      :title => 'Learn Excel Episode 1095: Dueling: Random Date',
      :description => 'Mike and Bill offer different ways of generating a random date between two dates. Episode 1095 shows you how.',
      :thumbnail_url => 'http://www.bestechvideos.com/thumbnails/0002/4218/6se4xqp894jkpmdxor6qm3gpi0_thumb.jpg',
      :views => 395,
      :featured => true
    )
  end

  desc 'Load test videos into the database.'
  task :categories => :environment do
    Category.create(:name => 'Ruby on Rails')
    Category.create(:name => 'ASP.NET')
    Category.create(:name => 'JavaScript')
    Category.create(:name => 'HTML')
    Category.create(:name => 'Conferences')
  end
end