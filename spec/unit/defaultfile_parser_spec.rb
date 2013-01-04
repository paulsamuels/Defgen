require 'support/spec_helper'
require 'defgen/defaultfile_parser'
require 'defgen/defaultfile'

module Defgen
  describe DefaultfileParser do
    subject(:defaultfile_parser) { DefaultfileParser.new }
    
    it { DefaultfileParser.should respond_to :parse }
    
    %w(array bool data dictionary float integer object string double url).each do |method|
      it { should respond_to method }
    end
    
    it "returns a Enumerable" do
      DefaultfileParser.parse('').should be_a_kind_of Enumerable
    end
    
    [
      [ 'array',      'array',      'NSArray *',      :strong, true  ],
      [ 'bool',       'bool',       'BOOL ',          :assign, false ],
      [ 'data',       'data',       'NSData *',       :strong, true  ],
      [ 'dictionary', 'dictionary', 'NSDictionary *', :strong, true  ],
      [ 'float',      'float',      'float ',         :assign, false ],
      [ 'integer',    'integer',    'NSInteger ',     :assign, false ],
      [ 'object',     'object',     'id ',            :strong, true  ],
      [ 'string',     'string',     'NSString *',     :copy,   true  ],
      [ 'double',     'double',     'double ',        :assign, false ],
      [ 'url',        'URL',        'NSURL *',        :strong, false ]
    ].each do |method_name, prefix, objc_type, ownership, object_setter|
      it "parses the string #{method_name} 'iVar'" do
        property = defaultfile_parser.parse("#{method_name} 'iVar'").first
      
        property.name.should eq('iVar')
        property.object_setter.should eq(object_setter)
        property.message_prefix.should eq(prefix)
        property.objc_type.should eq(objc_type)
        property.attributes.ownership.should eq(ownership)
      end
    end
    
    it "can handle a custom getter" do
      property = nil
      
      expect do
        property = defaultfile_parser.parse("bool 'valid', :getter => 'isValid'").first
      end.to_not raise_error
      
      property.attributes.getter.should eq('isValid')
    end
    
    it "can handle overriding ownership" do
      property = nil
      
      expect do
        property = defaultfile_parser.parse("array 'myCollection', :ownership => :weak").first
      end.to_not raise_error
      
      property.attributes.ownership.should eq(:weak)
    end
  end
end