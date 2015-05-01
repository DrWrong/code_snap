#!/usr/bin/env ruby
require "mercenary"
# require "yaml"

require_relative "commands/index"
require_relative 'commands/project'
# $GLOBAL_CONFIG = {}
# log =
Mercenary.program(:code_snaps) do |p|
  p.version '0.0.1'
  p.description 'A project auto generate tools'
  p.syntax 'code_snaps <subcommand> [options]'
  p.option 'config_file', '-c', '--config FILE', "config file"
  p.action do |args, options|
    # puts "I am here"
    if args.empty? || !p.has_command?(args.first)
      puts p
      exit
    end

  end
  p.command(:index) do |c|
    c.action do |_, options|
      handle = IndexCommand.new(options)
      handle.handle
    end
  end

  p.command(:project) do |c|
    c.syntax 'project [options]'
    c.description 'start a new project'

    c.option :project_name, "-n", "--name PROJECT_NAME", "the name of the project to be generate"
    c.option :project_directory, "-d", "--dir [DIRECTORY]", "the project generate directory"
    c.option :project_type, "-p", "--project PROJECT_TYPE", "the project type"
    c.option :project_options, "--args [ARGS1, ARGS2, ARGS3]", Array, "project specific args in the format a=b"

    c.action do |_, options|
      # validate user args
      if options[:project_name].nil? || options[:project_type].nil?
        puts c
        exit
      end
      options[:project_directory] = Dir.pwd if options[:project_directory].nil?
      keyvalues = options[:project_options]
      options[:project_options] = {}
      unless keyvalues.nil?
        keyvalues.each do |keyvalue|
          if keyvalues =~ /\w+=\w+/
            key, value = keyvalues.split("=")
            options["project_options"][key] = value
          end
        end
      end
      handle = ProjectCommand.new(options)
      handle.handle
    end
  end
end
