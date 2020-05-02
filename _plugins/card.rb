require_relative "./plugin_tools"

class CardBlock < Liquid::Block
  include PluginTools

    ALIGNMENT = ["left", "right"]

  def initialize(tag_name, params, tokens)
    super
    @params = params
  end

  def render(context)
    alignment, image = parse_parameters(context, @params)

    if ! ALIGNMENT.include?(alignment)
      raise ArgumentError, "Alignment mismatch in card tag, format expected {% card [#{ALIGNMENT.join(", ")}] image %}}, got {% card #{@params} %}"
    end
    image = post_asset(context, image)
    "<div class=\"card #{alignment}\"><img src=\"#{image}\" /><div class=\"outer\"><div class=\"inner\">#{convert_markdown_content(context, super.to_s.strip)}</div></div></div>"
  end

  Liquid::Template.register_tag("card", self)
end
