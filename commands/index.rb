require_relative 'base'
require_relative '../utils/file_path'
require 'yaml'
class IndexCommand < BaseCommand
  def initialize(options)
    super
    @template_path = @config["template_path"]
    if @template_path.relative_path?
      @template_path = File.join(@config["base_dir"], @template_path)
    end
  end

  def handle
    @project_config ={
      "projects" => []
    }
    Dir.foreach(@template_path) do |project_directory|
      unless project_directory.start_with?(".")
        config_file = File.join(@template_path, project_directory, ".config.yml")
        begin
          project_config = nil
          File.open(config_file, 'r') do |file|
            project_config = YAML.load(file)
          end
          name = project_config["name"]
          @project_config["projects"] << project_config["name"]
          @project_config[name] = {
            "path" => File.join(@template_path, project_directory),
            "necessary_args" => if project_config.has_key?("necessary_args") then project_config["necessary_args"]  else [] end,
          }
        rescue
        end
      end
    end
    File.open(@project_config_file, 'w') do |file|
      file.puts @project_config.to_yaml
    end

  end

end
