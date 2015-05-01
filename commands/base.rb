require 'yaml'
require 'logger'
require_relative '../utils/file_path'
class BaseCommand
  def initialize(options)
    # @configure = {}
    @options = options
    config_file = options["config_file"]
    if config_file.nil?
      config_file = File.join(File.dirname(__FILE__), *%w{ .. etc conf.yml })
    end
    begin
      File.open(config_file, 'r') do |file|
        @config = YAML.load(file)
      end
    rescue StandardError => e
      puts e
      exit
    end
    init_log
    init_project
  end

  def init_log
    file = @config["log"]["file"]
    if file == "STDOUT"
      file = STDOUT
    elsif file == "STDERR"
      file = STDERR
    end
    @logger = Logger.new(file)
    level = @config["log"]["level"]
    level_dict ={
      :unknown => Logger::UNKNOWN,
      :fatal => Logger::FATAL,
      :error => Logger::ERROR,
      :warn => Logger::WARN,
      :info => Logger::INFO,
    }
    begin
      @logger.level = level_dict[level]
    rescue StandardError => e
      @logger.level = Logger::INFO
    end
    @logger.info("log initized")
  end

  def init_project
    project_config = @config['project_config']
    if project_config.relative_path?
      # puts "relative_path"
      project_config = File.join(@config["base_dir"], project_config)
    end
    @project_config_file = project_config
    begin
      File.open(project_config, 'r') do |file|
        @project_config = YAML.load(file)
      end
    rescue
      @project_config = nil
    end
    @logger.info("project initized")
  end
end
