module Defgen
  class Property
    class UnsupportedOwnershipError < ArgumentError; end
    class Attributes
      VALID_OWNERSHIPS = [:strong, :weak, :assign, :unsafe_unretained, :retain, :copy]
      attr_accessor :ownership
      
      def initialize
        @ownership = :strong
      end
      
      def ownership= ownership
        raise UnsupportedOwnershipError unless ownership.nil? || VALID_OWNERSHIPS.include?(ownership)
        @ownership = ownership
      end
      
      VALID_OWNERSHIPS.each do |ownership|        
        # Turn valid ownerships into predicate methods. e.g. strong?
        define_method "#{ownership}?" do
          instance_variable_get("@ownership") == ownership
        end
      end
      
      def to_s
        "(#{['nonatomic', ownership].compact.join(', ')})"
      end
    end
  end
end