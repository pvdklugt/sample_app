module ApplicationHelper

  # Return a title on a per-page basis
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
     image_tag("logo.png", :alt => "Sample App", :class => "round")
  end

#   def micropost_maxlen
#     Micropost.validators_on(:content)[1].options[:maximum].to_s
#     Micropost._validators[:content][1].options[:maximum].to_s
#   end

end
