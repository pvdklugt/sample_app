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

  def micropost_maxlen
    # The _validators array might not be in the same order when in the console or in a web request
    # @micropost_maxlen = @micropost._validators[:content][1].options[:maximum].to_s
    # The solution below remedies this, but still doesn't seem to work when reloading the microposts page after errors
    # @micropost_maxlen = @micropost._validators[:content].find {|v| v.class == ActiveModel::Validations::LengthValidator} .options[:maximum].to_s  
    # So the length is now implemented as a constant in the Micropost model
    Micropost::MAX_CONTENT_LENGTH.to_s
  end

end
