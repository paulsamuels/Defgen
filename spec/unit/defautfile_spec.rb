require 'support/spec_helper'
require 'defgen/defaultfile'

module Defgen
  describe Defaultfile do
    subject(:defaultfile) { Defaultfile.new [], nil }
    
    it { should respond_to :to_iface }
    it { should respond_to :to_imp }
  end
end