require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do

  it 'should initialize variables' do
    get 'show'
    assigns[:presenter].should be_instance_of(HomePresenters::ShowPresenter)
  end


  describe "GET 'show'" do
    integrate_views
    
    it 'should be successful' do
      get 'show'
      response.should be_success
    end
  end
end
