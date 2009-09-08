module Spec
  module Cells
    module Example
      # Cell Examples live in $RAILS_ROOT/spec/cells/.
      #
      # Cell Examples use Spec::Cells::Example::CellExampleGroup,
      # which supports running specs for Cells in two modes, which
      # represent the tension between the more granular testing common in TDD
      # and the more high level testing built into rails. BDD sits somewhere
      # in between: we want to a balance between specs that are close enough
      # to the code to enable quick fault isolation and far enough away from
      # the code to enable refactoring with minimal changes to the existing
      # specs.
      #
      # == Isolation mode (default)
      #
      # No dependencies on views because none are ever rendered. The benefit
      # of this mode is that can spec the cell completely independent of
      # the view, allowing that responsibility to be handled later, or by
      # somebody else.
      #
      # == Integration mode
      #
      # To run in this mode, include the +integrate_views+ declaration
      # in your controller context:
      #
      #   describe ThingController do
      #     integrate_views
      #     ...
      #
      # In this mode, cell specs are run in the same way that rails
      # functional tests run — one set of tests for both the cells and
      # the views. The benefit of this approach is that you get wider coverage
      # from each spec. Experienced rails developers may find this an easier
      # approach to begin with, however we encourage you to explore using the
      # isolation mode and revel in its benefits.
      class CellExampleGroup < Spec::Rails::Example::FunctionalExampleGroup
        @@cell_class = nil

        class << self
          # Use integrate_views to instruct RSpec to render views in
          # your cell examples in Integration mode.
          #
          #   describe ThingCell do
          #     integrate_views
          #     ...
          #
          # See Spec::Cells::Example::CellExampleGroup for more
          # information about Integration and Isolation modes.
          def integrate_views(integrate_views = true)
            @integrate_views = integrate_views
          end
          
          def integrate_views? # :nodoc:
            @integrate_views
          end

          def inherited(klass) # :nodoc:
            klass.integrate_views(integrate_views?)
            klass.subject { cell }
            super
          end

          def set_description(*args) # :nodoc:
            super
            tests ActionController::Base
            if described_class && described_class.ancestors.include?(Cell::Base)
              cell_klass = if superclass.cell_class && superclass.cell_class.ancestors.include?(Cell::Base)
                superclass.cell_class
              else
                described_class
              end
              self.cell_class = cell_klass
            end
          end

          # When you don't pass a cell to describe, like this:
          #
          #   describe ThingsCell do
          #
          # ... then you must provide a cell_name within the context of
          # your cell specs:
          #
          #   describe "ThingCell" do
          #     cell_name :thing
          #     ...
          def cell_name(name)
            self.cell_class = "#{name}_cell".camelize.constantize
          end

          def cell_class=(new_class) # :nodoc:
            write_inheritable_attribute(:cell_class, new_class)
          end

          def cell_class # :nodoc:
            read_inheritable_attribute(:cell_class)
          end
        end
        
        before :each do
          unless self.class.cell_class and self.class.cell_class.ancestors.include?(Cell::Base)
            Spec::Expectations.fail_with <<-MESSAGE
Cell specs need to know what cell is being specified. You can
indicate this by passing the cell to describe():

  describe MyCell do

or by declaring the cell's name

  describe "a MyCell" do
    cell_name :my #invokes the MyCell
end
MESSAGE
          end

          @controller.response = response
          @controller.session = session
          @controller.params = params
          
          self.class.cell_class.default_template_format = :html
          @cell = self.class.cell_class.new(@controller)
          @opts = @cell.instance_variable_get(:@opts)

          @cell.extend CellInstanceMethods
          @cell.integrate_views! if integrate_views?
        end

        attr_reader :request, :controller, :cell, :opts

        def integrate_views?
          @integrate_views || self.class.integrate_views?
        end

        def render_cell(state, opts = {}, params = {})
          @opts.update(opts || {})
          params.update(params || {})

          #@controller.send :forget_variables_added_to_assigns   # this fixes bug #1, PARTLY.

          return @cell.render_state(state)
        end

        def orig_assigns
          @cell.assigns_for_view
        end
        
        protected

          def _assigns_hash_proxy
            @_assigns_hash_proxy ||= Spec::Rails::Example::AssignsHashProxy.new(self) { @cell }
          end

        module CellInstanceMethods #:nodoc:
          def render_view_for(opts, state)
            return super(opts, state) if integrate_views?
            nil
          end
          
          def integrate_views!
            @integrate_views = true
          end

          private

            def integrate_views?
              @integrate_views
            end
        end
        
        Spec::Example::ExampleGroupFactory.register(:cell, self)
      end
    end
  end
end