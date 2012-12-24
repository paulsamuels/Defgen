class String
  def upcase_first
    self.dup.tap { |string| string[0] = string[0].upcase }
  end
end