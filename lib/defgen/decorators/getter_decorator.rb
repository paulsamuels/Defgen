require 'delegate'

module Defgen
  class GetterDecorator < SimpleDelegator    
    def objc_type
      super.strip
    end
    
    def prefix
      super.downcase
    end
    
    def parameter
      if attributes.getter.nil? || attributes.getter.empty?
        super
      else
        attributes.getter
      end
    end
    
    def get_binding
      binding
    end
  end
end