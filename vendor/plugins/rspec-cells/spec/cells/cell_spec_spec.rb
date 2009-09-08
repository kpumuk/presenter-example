require File.dirname(__FILE__) + '/../spec_helper'

describe CellSpecCell, 'with class specified' do
  it 'should load correct example group' do
    self.should respond_to(:cell)
  end
end

describe 'CellSpecCell with type specified', :type => :cell do
  cell_name :cell_spec

  it 'should load correct example group' do
    self.should respond_to(:cell)
  end
end

describe 'CellSpecCell.render_cell method' do
  cell_name :cell_spec
  
  it 'should pass options to cell' do
    render_cell :modify_opts, :test => 'hello'
    opts[:test].should_not be_nil
  end

  it 'should modify options in cell' do
    render_cell :modify_opts, :test => 'hello'
    opts[:test].should == 'hello, world'
  end

  it 'should pass params to cell' do
    result = render_cell(:check_params, { :test => 'hello' }, :add => ', world')
    result.should == 'hello, world'
  end
  
  it 'should render nothing when integrate_views=false' do
    result = render_cell(:modify_opts, :test => 'hello')
    result.should be_nil
  end
  
  describe "with integrate_views" do
    integrate_views
    
    it 'should render view when integrate_views=true' do
      result = render_cell(:modify_opts, :test => 'hello')
      result.should == '<h1>hello, world</h1>'
    end

    it 'should not render view when string is returned from cell' do
      result = render_cell(:state_without_template)
      result.should == 'this state has not template'
    end
    
    it 'should allow have_tag expectation' do
      result = render_cell(:modify_opts, :test => 'hello')
      result.should have_tag('h1', 'hello, world')
    end
  end
end
