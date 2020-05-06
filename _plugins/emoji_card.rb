require_relative "./plugin_tools"

class EmojiCardBlock < Liquid::Block
  include PluginTools

    ALIGNMENT = ["left", "right"]

  def initialize(tag_name, params, tokens)
    super
    @params = params
  end

  def render(context)
    alignment, emoji = parse_parameters(context, @params)

    if ! ALIGNMENT.include?(alignment)
      raise ArgumentError, "Alignment mismatch in emoji card tag, format expected {% card [#{ALIGNMENT.join(", ")}] image %}}, got {% card #{@params} %}"
    end
    "<div class=\"emoji-card #{alignment}\"><div class=\"img\">#{emoji}</div><div class=\"outer\"><div class=\"inner\">#{convert_markdown_content(context, super.to_s.strip)}</div></div></div>"
  end

  Liquid::Template.register_tag("emoji_card", self)
end
