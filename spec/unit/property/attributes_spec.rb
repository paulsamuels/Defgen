require 'support/spec_helper'
require 'defgen/property/attributes'

module Defgen
  class Property
    describe Attributes do
      subject(:attributes) { Attributes.new }
      
      it { should respond_to :property }
      it { should respond_to :ownership }
      it { should respond_to :getter }
                        
      Attributes::VALID_OWNERSHIPS.each do |semantic|
        it "creates the predicate method #{semantic}?" do
          should respond_to "#{semantic}?"
        end
      end
      
      it "uses strong as the default ownership" do
        attributes.ownership.should == :strong
      end
      
      describe "ownerships=" do
        specify { expect { attributes.ownership = :a }.to raise_error UnsupportedOwnershipError }
        
        Attributes::VALID_OWNERSHIPS.each do |semantic|
          it "allows an ownership type of #{semantic}" do
            expect { attributes.ownership = semantic }.to_not raise_error
          end
        end
      end
      
      describe "to_s" do
        it "should default to (nonatomic, strong)" do
          attributes.to_s.should eq('(nonatomic, strong)')
        end
        
        it "should include correct ownership" do
          attributes.ownership = :weak
          attributes.to_s.should eq('(nonatomic, weak)')
        end
        
        it "should allow nil setter semantic" do
          attributes.ownership = nil
          attributes.to_s.should eq('(nonatomic)')
        end
      end
      
      it "uses a custom getter" do
        FakeProperty = Struct.new(:prefix)
        attributes.property = FakeProperty.new('ps')
        attributes.getter = 'isValid'
        attributes.to_s.should eq('(nonatomic, strong, getter=ps_isValid)')
      end
    end
  end
end