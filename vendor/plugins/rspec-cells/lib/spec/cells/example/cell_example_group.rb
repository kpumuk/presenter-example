module Spec
  module Cells
    module Example
      # Cell Examples live in $RAILS_ROOT/spec/cells/.
      class CellExampleGroup < Spec::Rails::Example::FunctionalExampleGroup
        include ActionController::TestProcess
        include ActionController::Assertions

        class << self
          def inherited(klass) # :nodoc:
            klass.cell_class_name = cell_class_name
            klass.integrate_views(integrate_views?)
            super
          end

          # Use this to instruct RSpec to render views in your controller examples (Integration Mode).
          #
          #   describe ThingController do
          #     integrate_views
          #     ...
          #
          # See Spec::Rails::Example::ControllerExampleGroup for more information about
          # Integration and Isolation modes.
          def integrate_views(integrate_views = true)
            @integrate_views = integrate_views
          end
          
          def integrate_views? # :nodoc:
            @integrate_views
          end

          # You MUST provide a cell_name within the context of
          # your cell specs:
          #
          #   describe "ThingCell" do
          #     cell_name :thing
          #     ...
          def cell_name(name)
            @cell_class_name = "#{name}_cell".camelize
          end
          attr_accessor :cell_class_name # :nodoc:
        end
        
        before :each do
          unless @cell_class.ancestors.include?(Cell::Base)
            Spec::Expectations.fail_with <<-EOE
            You have to declare the cell name in cell specs. For example:
            describe "The ExampleCell" do
              cell_name :example #invokes the ExampleCell
            end
            EOE
          end

          @controller = ActionController::Base.new
          @request    = ActionController::TestRequest.new
          @response   = ActionController::TestResponse.new
          @controller.request  = @request
          @controller.response = @response
          @controller.params   = {}
          @cell = @cell_class.new(@controller)

          (class << @cell; self; end).class_eval do
            def cell_path #:nodoc:
              self.class.name.underscore.gsub('_cell', '')
            end
            include CellInstanceMethods
          end
          @cell.integrate_views! if @integrate_views
        end

        attr_reader :response, :request, :controller, :cell

        def initialize(defined_description, &implementation) #:nodoc:
          super
          @cell_class_name = self.class.cell_class_name.to_s
          if @cell_class_name.empty?
            @cell_class_name = self.class.described_type.to_s
          end

          @cell_class = @cell_class_name.constantize
          raise "Can't determine cell class for #{@cell_class_name}" if @cell_class.nil?
          @cell_class.default_template_format = :html

          @integrate_views = self.class.integrate_views?
        end

        def render_cell(state, opts = {}, params = {})
          self.opts.merge!(opts || {})
          @request.parameters.merge!(params)

          #@controller.send :forget_variables_added_to_assigns   # this fixes bug #1, PARTLY.

          return cell.render_state(state)
        end
        
        def opts
          @cell.instance_variable_get(:@opts) || {}
        end

        def params
          @cell.params
        end

        def session
          @cell.session
        end

        def request
          @cell.request
        end
        
        def assigns
          HashWithIndifferentAccess.new(@cell.assigns_for_view)
        end

        module CellInstanceMethods #:nodoc:
          def render_view_for(opts, state)
            return super(state) if integrate_views?
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