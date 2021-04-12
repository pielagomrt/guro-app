module ApplicationHelper
  def raw_strip(text)
    raw(text).gsub('&amp;#39;', '\'').gsub('&amp;quot;', '"')
  end
end
