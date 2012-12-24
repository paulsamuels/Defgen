require 'xcodeproj'

module Defgen
  class XcodeprojAdapter
    def initialize proj, path
      @proj, @path = proj, path
    end
    
    def name
      @proj.targets.first.name
    end
    
    def prefix
      prefix = root_object.attributes['CLASSPREFIX']
      if prefix.nil? || prefix.empty?
        'PS'
      else
        prefix.upcase
      end
    end
    
    def objects
      @proj.objects
    end
    
    def organization
      root_object.attributes['ORGANIZATIONNAME']
    end
    
    def main_group
      root_object.main_group.groups.first
    end
    
    def main_target
      root_object.targets.first
    end
    
    def save
      @proj.save_as @path
    end
    
    private
    
    def root_object
      @proj.root_object
    end
  end
end