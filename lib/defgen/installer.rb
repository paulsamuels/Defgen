module Defgen
  class Installer
    def self.install(path, defaultfile, proj)
      new(path, defaultfile, proj).install
    end
    
    def initialize path, defaultfile, proj
      self.path, self.defaultfile, self.proj = path, defaultfile, proj
    end
    
    def install
      install_files
      configure_xcode
      proj.save
    end
    
    private
    
    attr_accessor :path, :defaultfile, :proj
    
    def install_files
      FileUtils.mkdir_p properties_path
      
      { '.h' => defaultfile.to_iface, '.m' => defaultfile.to_imp }.each do |ext, content|
        File.open("#{file_path}#{ext}", 'w') do |f| 
          f.puts content
        end
      end
    end
    
    def configure_xcode
      return if proj.objects.map { |o| o.name if o.respond_to? :name }.include? "#{file_name}.h"

      main_group.new_file "#{file_path}.h", properties_group
      implementation = main_group.new_file "#{file_path}.m", properties_group
      main_target.source_build_phase.add_file_reference implementation
    end
    
    def properties_path
      "#{File.dirname(path)}/#{target_name}/#{prefix}Properties"
    end
    
    def properties_group
      "#{prefix}Properties"
    end
    
    def properties_group_path
      "#{main_target_name}/#{properties_group}"
    end
    
    def file_path
      "#{properties_path}/#{file_name}"
    end
    
    def file_name
      "NSUserDefaults+#{prefix}Properties"
    end
    
    def prefix
      proj.prefix.upcase
    end
    
    def main_group
      proj.main_group
    end
    
    def main_target
      proj.main_target
    end
    
    def target_name
      main_target.name
    end
  end
end