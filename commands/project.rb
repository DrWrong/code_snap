require_relative 'base'
require_relative '../utils/erb_render'


class ProjectCommand < BaseCommand

  def initialize(options)
    super
    init_params
    init_context
  end

  def init_params
    type = @options[:project_type]
    unless @project_config["projects"].include? type
      @logger.FATAL "the project  #{type}, not exist"
      exist
    end
    @specific_project_config = @project_config[type]
    @project_name = @options[:project_name]
  end

  def init_context
    @context = {}
    user_provide_options = @options[:project_options]
    @specific_project_config["necessary_args"].each do |name|
      begin
        @context[name] = user_provide_options[name]
      rescue StandardError => e
        puts "user provide args not enought the args need is:"
        puts @specific_project_config["necessary_args"]
        exit
      end
    end
    @context["project_name"] = @project_name
  end

  def handle

    project_template_path = @specific_project_config["path"]
    project_dir = @options[:project_directory]
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

    h = ErbRender.new(@context)
    h.render(absolut_path, dest_filename)
  end
end
