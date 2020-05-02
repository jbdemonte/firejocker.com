class Spacer < Liquid::Tag
  def render(context)
    "<div class=\"spacer\"></div>"
  end
  Liquid::Template.register_tag("spacer", self)
end
