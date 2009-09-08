require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe VideoCell do
  context '.videos' do
    it 'should initialize :videos variable' do
      videos = mock('Videos')
      render_cell :videos, :videos => videos
      assigns[:videos].should be(videos)
    end
  end
end