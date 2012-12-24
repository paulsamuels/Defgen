require 'support/spec_helper'
require 'defgen/property'

module Defgen
  shared_examples "a property" do
    let(:property) { described_class.new }
  
    it { should respond_to :name }
    it { should respond_to :objc_type }
    it { should respond_to :message_prefix }
    it { should respond_to :attributes }
    it { should respond_to :object_setter }
    it { should respond_to :parameter }
  
    specify { expect { |b| described_class.new(&b) }.to yield_control }
  
    it "should be able to yield on new" do
      expect {
        described_class.new do |property, attributes|
          property.objc_type = 'NSData *'
        end
      }.to_not raise_error
      
      described_class.new do |property, attributes|
        property.should respond_to :name
      end
    end

    describe "objc_type=" do
      good_types = Property::VALID_TYPES
      bad_types  = ['Test *', 'NSURLConnection *']
      
      good_types.each do |type|
        it "should allow the objc_type #{type}" do
          expect { property.objc_type = type }.to_not raise_error
        end
      end
    
      bad_types.each do |type|
        it "should not allow the objc_type #{type}" do
          expect { property.objc_type = type }.to raise_error ArgumentError
        end
      end
    end
    
    [
      [ 'test',        'PSTest'],
      [ 'isValid',     'PSIsValid'],
      [ 'under_score', 'PSUnder_score']
    ].each do |name, expected|
      it "returns an appropriate key for #{name}" do
        property.name   = name
        property.prefix = 'ps'
        property.key.should eq(expected)
      end
    end
  end
end