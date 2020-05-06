class YouTube < Liquid::Tag
  Syntax = /^\s*([^\s]+)(?:\s+(\d+)\s+(\d+)(?:\s+([0-9.]+))?\s*)?/

  def initialize(tagName, params, tokens)
    super

    if params =~ Syntax then
      @id = $1

      if $2.nil? then
          @width = 560
          @height = 420
      else
          @width = $2.to_i
          @height = $3.to_i
      end

      if $4 then
        ratio = $4.to_f
        @width = (ratio * @width).to_i
        @height = (ratio * @height).to_i
      end

    else
      raise "YouTube ID is missing"
    end
  end

  def render(context)
    "<iframe class=\"video\" width=\"#{@width}\" height=\"#{@height}\" src=\"https://www.youtube.com/embed/#{@id}?\" style=\"border:0;\" allow=\"accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>"
  end

  Liquid::Template.register_tag "youtube", self
end
