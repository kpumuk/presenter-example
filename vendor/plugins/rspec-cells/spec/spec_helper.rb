dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.expand_path("#{dir}/../spec_resources/cells"))
#$LOAD_PATH.unshift(File.expand_path("#{dir}/../rspec/lib"))
#$LOAD_PATH.unshift(File.expand_path("#{dir}/../rspec-rails/lib"))

require File.expand_path("#{dir}/../../../../spec/spec_helper")
require File.expand_path("#{dir}/../spec_resources/cells/cell_spec_cell")
require 'spec/cells'
require 'cell/template_finder'

module Cell
  class Base
    def self.view_for_state(action_view, state)
      template_path = File.join(File.dirname(__FILE__), '..', 'spec_resources', 'cells', cell_name, state)
      begin
        Template.new(self, template_path, true, {}).set_extension_and_filename
      end
      puts "TRYING: #{template_path} returns #{action_view.finder.file_exists?(template_path).inspect}"
      return action_view.finder.file_exists?(template_path) && template_path
    end
  end
  
  class TemplateFinder
    def possible_cell_paths
      [ File.join(File.dirname(__FILE__), '..', 'spec_resources', 'cells') ]
    end
  end
end
