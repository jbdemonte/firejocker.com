require "liquid"

module PluginTools

  # Split spaced or quoted / double quoted parameters and interpolate variables
  # @example parse_parameters(LiquidContext, 'top 3 "{{ site.author }}"')
  def parse_parameters(context, params)
    parameters = Liquid::Template.parse(params).render context
    parameters.strip!
    result = []
    while parameters.length > 0 do
      if ['"', "'"].include? parameters[0]
        start = 1
        stop = parameters.index(parameters[0], 1)
        if !stop then raise SyntaxError, "Missing ending #{parameters[0]} in [#{params.strip}]" end
      else
        start = 0
        stop = parameters.index(" ") || parameters.length + 1
      end
      result.push(parameters[start...stop])
      parameters = (parameters[(stop + 1)..-1] || "").strip
    end
    if parameters.length > 0
      result.push(parameters)
    end
    result
  end

  # Generate a post relative image path
  # @example post_asset(LiquidContext, "subdir", "image.png")
  def post_asset(context, *directories)
    build_post_asset_url(context, context.registers[:page]["path"], directories)
  end

  def build_post_asset_url(context, path, directories)
    # ignore absolute url, URL may already has been generated (case of filter for example)
    if directories.length == 1 && directories[0][0] == "/"
      return directories[0]
    end

    site = context.registers[:site]
    baseurl = site.config["baseurl"].to_s.chomp("/")
    post_directory = path.sub("_posts/", "").chomp(".md")

    path = directories
               .map { |directory| directory.strip }
               .select { |item| !item.strip.empty? }
               .join("/")

    "#{baseurl}/assets/posts/#{post_directory}/#{path}"
  end

  def convert_markdown_content(context, content)
    site = context.registers[:site]
    converter = site.find_converter_instance(::Jekyll::Converters::Markdown)
    converter.convert(content)
  end
end