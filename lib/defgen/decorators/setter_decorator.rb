module Defgen
  class SetterDecorator < GetterDecorator    
    def message_prefix
      object_setter ? 'Object' : super.upcase_first
    end
    
    def prefix
      super.downcase.upcase_first
    end
  end
end