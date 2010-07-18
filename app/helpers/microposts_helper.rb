module MicropostsHelper
  def wrap(content)
    wrap_text(content)
  end

  private
  def wrap_text(txt, col = 30)
      txt.gsub(/(.{1,#{col}})( +|$)\n?|(.{#{col}})/,
          "\\1\\3\n")
  end

  def wrap_long_string(text, max_width = 30)
    zero_width_space = ""
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text : 
      text.scan(regex).join(zero_width_space)
  end

end
