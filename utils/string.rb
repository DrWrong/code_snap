class String
  def relative_path?
    return !self.start_with?('/')
  end
end
