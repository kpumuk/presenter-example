require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do

  it 'should initialize variables' do
    get 'show'
    assigns[:top_videos].should_not be_nil
    assigns[:categories].should_not be_nil
    assigns[:featured_videos].should_not be_nil
    assigns[:latest_videos].should_not be_nil
  end


  describe "GET 'show'" do
    integrate_views
    
    it 'should be successful' do
      get 'show'
      response.should be_success
    end
  end
end
