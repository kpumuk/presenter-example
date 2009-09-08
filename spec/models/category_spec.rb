require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# Dumb specs
describe Category do
  it 'should respond to :top' do
    expect { Category.create.videos }.to_not raise_error
  end
end
