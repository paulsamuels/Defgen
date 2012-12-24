module Defgen
  class DefaultfileBuilder
    attr_accessor :parser, :project_settings, :defaultfile
    
    def self.build
      new.tap { |instance| yield(instance) }.build
    end
    
    def build
      properties = parser.parse(defaultfile).each do |property| property.prefix = project_settings.prefix end
      Defaultfile.new properties, project_settings
    end
  end
end