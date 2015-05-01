require_relative 'base'
require_relative '../utils/erb_render'


class ProjectCommand < BaseCommand

  def handle
    type = @options[:project_type]
    unless @project_config["projects"].include? type
      @logger.FATAL "the project  #{type}, not exist"
      exist
    end
    config = @project_config[type]
    project_template_path = config["path"]
    project_dir = @options[:project_directory]
    @project_name = @options[:project_name]
    directory_to_create = File.join(project_dir, @project_name)
    unless Dir.exist?(directory_to_create)
      Dir.mkdir(directory_to_create)
    end
    reverse_copy(project_template_path, directory_to_create)
  end

  def reverse_copy(from_directory, to_directory)
    Dir.foreach(from_directory) do |filename|
      unless filename.start_with?(".")
        absolut_path = File.join(from_directory, filename)
        dest_filename = filename % {:project_name => @project_name }
        dest_filename = File.join(to_directory, dest_filename)

        if File.directory?(absolut_path)
          Dir.mkdir(dest_filename)
          reverse_copy(absolut_path, dest_filename)
        else
          file_content_render(absolut_path, dest_filename)
        end
      end

    end
  end

  def file_content_render(absolut_path, dest_filename)
    context = @options[:project_options]
    context["project_name"] = @project_name
    h = OpenStruct.new(context)
    h.render(absolut_path, dest_filename)
  end
end
