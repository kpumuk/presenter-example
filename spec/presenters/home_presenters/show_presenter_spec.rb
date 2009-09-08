require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe HomePresenters::ShowPresenter do
  before :each do
    @presenter = HomePresenters::ShowPresenter.new
  end
  
  it 'should respond to :top_videos' do
    expect { @presenter.top_videos }.to_not raise_error
  end

  it 'should respond to :categories' do
    expect { @presenter.categories }.to_not raise_error
  end

  it 'should respond to :featured_videos' do
    expect { @presenter.featured_videos }.to_not raise_error
  end

  it 'should respond to :latest_videos' do
    expect { @presenter.latest_videos }.to_not raise_error
  end
end
