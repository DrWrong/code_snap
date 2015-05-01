require_relative 'base'

class ProjectCommand < BaseCommand

  def handle
    type = @options[:project_type]
    unless @project_config["projects"].include? type
      @logger.FATAL "the project  #{type}, not exist"
      exist
    end
    config = @project_config[type]
    project_dir = @options[:project_directory]
    project_name = @options[:project_name]
    directory_to_create = File.join(project_dir, project_name)
    unless Dir.exist?(directory_to_create)
      Dir.mkdir(directory_to_create)
    end

  end

end
