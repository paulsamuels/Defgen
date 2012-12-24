require 'support/spec_helper'
require 'defgen/defaultfile_builder'

module Defgen
  describe DefaultfileBuilder do
    subject(:builder) { DefaultfileBuilder.new }
    
    it { should respond_to :parser }
    # it { should respond_to :project_settings }
    it { should respond_to :build }
  end
end