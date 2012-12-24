module Defgen
  class Property
    VALID_TYPES = ['NSData *', 'NSArray *', 'BOOL ', 'NSDictionary *', 'float ', 'NSInteger ', 'id ', 'NSString *', 'double ', 'NSURL *']
    attr_accessor :name, :objc_type, :message_prefix, :prefix, :attributes, :object_setter
        
    def initialize
      self.attributes = Attributes.new
      yield self, attributes if block_given?
    end
        
    def objc_type= objc_type
      raise ArgumentError unless VALID_TYPES.include? objc_type
      @objc_type = objc_type
    end
    
    def key
      "#{prefix.upcase}#{name.upcase_first}"
    end
    
    def parameter
      name
    end
    
    def get_binding
      binding
    end
  end
end

require 'defgen/property/attributes'