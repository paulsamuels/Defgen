require 'support/spec_helper'
require 'support/property_accessor_examples'
require 'defgen/property'
require 'defgen/decorators/setter_decorator'

module Defgen
  describe SetterDecorator do
    include_examples "property accessors"
    
    before do
      @property = Property.new
    end
    
    subject(:decorator) { SetterDecorator.new(@property) }
    
    [
      ['ps', 'Ps'],
      ['PS', 'Ps']
    ].each do |input, expected|
      it "camelizes prefix" do
        @property.prefix = input
        decorator.prefix.should eq(expected)
      end
    end
    
    [
      ['data',  'Data'],
      ['bool',  'Bool']
    ].each do |message_prefix, expected|
      it "generates a camalized message_prefix '#{expected}" do
        @property.message_prefix = message_prefix
        decorator.message_prefix.should eq(expected)
      end
    end
    
    it "uses an Object setter" do
      @property.object_setter  = true
      @property.message_prefix = 'Bool'
      decorator.message_prefix.should eq('Object')
    end
  end
end