module Defgen
  class DefaultfileParser
    def self.parse string
      new.parse string
    end
    
    def initialize
      @properties = []
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
      define_method method_name do |name|
        Property.new do |property, attributes|
          property.name           = name
          property.object_setter  = object_setter
          property.message_prefix = prefix
          property.objc_type      = objc_type
          attributes.ownership    = ownership
          
          @properties << property
        end
      end
    end
    
    def parse string
      instance_eval string
      @properties
    end
  end
end