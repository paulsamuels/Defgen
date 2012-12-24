require 'support/spec_helper'
require 'defgen/defaultfile'

module Defgen
  describe 'Defaultfile.parse' do
    
    # [
    #   { prefix: 'bool',       name: 'valid',       objc_type: 'BOOL',          ownership: :assign },
    #   { prefix: 'array',      name: 'collection',  objc_type: 'NSArray *',      ownership: :strong },
    #   { prefix: 'data',       name: 'someData',    objc_type: 'NSData *',       ownership: :strong },
    #   { prefix: 'dictionary', name: 'options',     objc_type: 'NSDictionary *', ownership: :strong },
    #   { prefix: 'float',      name: 'ratio',       objc_type: 'float',         ownership: :assign },
    #   { prefix: 'integer',    name: 'count',       objc_type: 'NSInteger',     ownership: :assign },
    #   { prefix: 'object',     name: 'someObject',  objc_type: 'id',            ownership: :strong },
    #   { prefix: 'string',     name: 'user_name',   objc_type: 'NSString *',     ownership: :copy   },
    #   { prefix: 'double',     name: 'ratio',       objc_type: 'double',        ownership: :assign },
    #   { prefix: 'url',        name: 'someWebsite', objc_type: 'NSURL *',        ownership: :strong },
    # ].each do |options|
    #   it "creates a valid #{options[:prefix]}" do
    #     result = Defaultfile.parse "#{options[:prefix]} '#{options[:name]}'"
    #     result.name.should eq(options[:name])
    #     result.message_prefix.should eq(options[:prefix])
    #     result.objc_type.should eq(options[:objc_type])
    #     result.attributes.ownership.should eq(options[:ownership])
    #   end
    # end
  end
end