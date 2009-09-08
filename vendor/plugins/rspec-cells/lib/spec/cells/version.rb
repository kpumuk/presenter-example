module Spec
  module Cells
    module VERSION #:nodoc:
      unless defined? MAJOR
        MAJOR  = 0
        MINOR  = 1
        TINY   = 0

        STRING = [MAJOR, MINOR, TINY].join('.')

        SUMMARY = "rspec-cells #{STRING}"
      end
    end
  end
end