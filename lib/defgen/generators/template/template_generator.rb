require 'thor/group'

class TemplateGenerator < Thor::Group
  include Thor::Actions

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end
  
  templates = Dir.glob("#{source_root}/*.erb")
  TEMPLATES = templates.map { |f| File.basename(f, '.erb') }
  
  TEMPLATES.each do |template|
    const_set "#{template.upcase}_SOURCE", File.join(source_root, "#{template}.erb")
    const_set "#{template.upcase}_DEST", "defgen/#{template}.erb"
    
    self.class.send :define_method, "#{template}_template" do
      load_template const_get("#{template.upcase}_SOURCE"), const_get("#{template.upcase}_DEST")
    end
  end
  
  def self.create_stubs
    new.create_stubs
  end
  
  def create_stubs
    TEMPLATES.map(&:upcase).each do |template_file|
      template self.class.const_get("#{template_file}_SOURCE"), self.class.const_get("#{template_file}_DEST")
    end
  end
    
  private
  
  def self.load_template source, destination
    return File.open(destination).read if File.exist? destination
    ERB.new(File.open(source).read).result
  end
end