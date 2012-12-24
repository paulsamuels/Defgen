require 'support/spec_helper'
require 'support/property_accessor_examples'
require 'defgen/property'
require 'defgen/decorators/getter_decorator'

module Defgen
  describe GetterDecorator do
    include_examples "property accessors"
    
    before do
      @property = Property.new
    end
    
    subject(:decorator) { GetterDecorator.new(@property) }
    
    [
      ['NSData *', 'NSData *'],
      ['BOOL ',    'BOOL']
    ].each do |input, output|
      it "strips white space from the objc_type" do
        @property.objc_type = input
        decorator.objc_type.should eq(output)
      end
    end
    
    it "downcases the prefix" do
      @property.prefix = 'PS'
      decorator.prefix.should eq('ps')
    end
  end
end