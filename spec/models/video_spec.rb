require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# Dumb specs
describe Video do
  it 'should respond to :top' do
    expect { Video.top }.to_not raise_error
  end

  it 'should respond to :latest' do
    expect { Video.latest }.to_not raise_error
  end

  it 'should respond to :featured' do
    expect { Video.featured }.to_not raise_error
  end

  it 'should respond to :category' do
    expect { Video.create.category }.to_not raise_error
  end
end
