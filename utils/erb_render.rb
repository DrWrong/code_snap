require "ostruct"
require "erb"

class OpenStruct

  def render(template, dest_filename)
    erb = ERB.new(File.read(template))
    r = erb.result(binding)
    File.open(dest_filename, 'w') do |f|
      f.write(r)
    end
  end
end
