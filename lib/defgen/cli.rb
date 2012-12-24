require 'Thor'
require 'fileutils'

module Defgen
  class CLI < Thor

    desc "stubs", "Generate template stubs"
    def stubs
      TemplateGenerator.create_stubs
    end
      
    desc "parse", 'Parse a "Defaultfile" and modify the Xcodeproj'
    method_option :filename, default: 'Defaultfile', 
    aliases: '-f',
    desc:    'Specify the input file path'
    def parse
      
      path = Dir['*.xcodeproj'].first
      
      if path.nil?
        puts('.xcodeproj file not found')
        puts
        help
        exit 1 
      end
      
      unless File.exist? options[:filename]      
        puts('no Defaultfile found')
        puts
        help
        exit 1
      end
      
      proj = XcodeprojAdapter.new(Xcodeproj::Project.new(path), path)
      
      defaultfile = DefaultfileBuilder.build { |builder|
        builder.project_settings = proj
        builder.parser           = DefaultfileParser
        builder.defaultfile      = File.open(options[:filename]).read
      }
      
      Installer.install(path, defaultfile, proj)
    end
      
    default_task :parse
  end
end