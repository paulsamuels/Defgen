require 'date'

module Defgen
  class Defaultfile
    attr_accessor :project_settings
    attr_reader :class_properties
    
    def initialize class_properties, project_settings
      @class_properties     = class_properties
      self.project_settings = project_settings
    end
    
    def to_iface
      render TemplateGenerator.interface_template
    end
    
    def to_imp
      render TemplateGenerator.implementation_template
    end
    
    private
    
    def render template
      prefix       = project_settings.prefix
      project_name = project_settings.name
      author       = project_settings.organization
      
      ERB.new(template, nil, '<>').result binding
    end
        
    def key_constants
      padding = class_properties.max_by { |p| p.key.length }.key.length
      constant_template = TemplateGenerator.constant_template
      
      String.new.tap { |out|
        class_properties.each do |property|
          out << ERB.new(constant_template).result(binding)
        end
      }
    end
    
    def accessors
      getter_template = TemplateGenerator.getter_template
      setter_template = TemplateGenerator.setter_template
      
      String.new.tap { |out|
        class_properties.each do |property| 
          out << ERB.new(getter_template).result(GetterDecorator.new(property).get_binding) + "\n"
          out << ERB.new(setter_template).result(SetterDecorator.new(property).get_binding)
          out << "\n" unless class_properties.last == property
        end
      }
    end
    
    def properties
      property_template = TemplateGenerator.property_template
      
      String.new.tap { |out|
        class_properties.each do |property|
          out << ERB.new(property_template).result(property.get_binding)
        end
      }
    end
  end
end