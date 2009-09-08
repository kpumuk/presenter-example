require 'spec/cells/example/cell_example_group'

module Spec
  module Cells
    # Spec::Cells::Example extends Spec::Example (RSpec's core Example module) to provide
    # Cells-specific contexts for describing Cells.
    #
    # == Cells Examples
    #
    # These align somewhat with functional tests in rails, except that they do not actually render views (though you can force rendering of views if you prefer). Instead of setting expectations about what goes on a page, you set expectations about what templates get rendered.
    #
    # See Spec::Cells::Example::CellExampleGroup
    module Example
    end
  end
end
