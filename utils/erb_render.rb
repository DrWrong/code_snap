require "ostruct"
require "erb"

class  ErbRender

  def initialize(context)
    @context = context
  end

  def render(template, dest_filename)
    puts @project_name
    erb = ERB.new(File.read(template))
    r = erb.result(binding)
    File.open(dest_filename, 'w') do |f|
      f.write(r)
    end
  end
end
