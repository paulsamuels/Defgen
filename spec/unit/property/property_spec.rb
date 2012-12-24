require 'support/spec_helper'
require 'support/property_examples'
require 'defgen/property'

module Defgen
  describe Property do
    it_behaves_like "a property"
    subject(:property) { Property.new }
  end
end