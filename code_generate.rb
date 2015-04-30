#!/usr/bin/env ruby

require "optparse"

class Parse
  attr_reader :options
  def initialize(args)
    @user_args = args
    @options = {
      :project_name => nil,
      :project_dir => Dir.pwd,
      :project_type => nil,
      :project_options => {}
    }
  end

  def parse
    opt_parse = OptionParser.new do |opts|
      opts.banner = "An project auto generate tools"
      opts.on("-n", "--name PROJECT_NAME",
      "the name of the project to be generate") do |name|
        @options[:project_name] = name
      end
      opts.on("-d", "--dir [DIRECTORY]",
      "the project generate directory") do |directory|
        @options[:directory] = directory
      end
      opts.on("-t", "--type TYPE", "the project type") do |type|
        @options[:project_type] = type
      end
      opts.on("--args [ARGS1, ARGS2, ARGS3]", Array, "project specific args in the format a=b") do |arglist|
        arglist.each do |keyvalues|
          key, value = keyvalues.split("=")
          @options[:project_options][key] = value
        end
      end
      opts.on("-h", "--help", "Print help") do
        puts opts
        exit
      end
    end
    opt_parse.parse!(@user_args)
    if @options[:project_name].nil? || @options[:project_type].nil?
        puts opt_parse.help()
        exit 1
    end
  end

end

parse = Parse.new(ARGV)
parse.parse
puts parse.options
