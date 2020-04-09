# Declare module of your plugin under Jekyll module
module Jekyll::CustomFilter

  # Each method of the module creates a custom Jekyll filter
  def blog_asset(input)
    baseurl = @context.registers[:site].config["baseurl"].to_s.chomp("/")
    path = @context.registers[:page].path.to_s.sub('_posts/', '').chomp(".md")
    result = "#{baseurl}/assets/posts/#{path}/#{input}"
  end
end

Liquid::Template.register_filter(Jekyll::CustomFilter)
