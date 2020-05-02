require_relative "./plugin_tools"

class ImageGalleryBlock < Liquid::Block

  include PluginTools

  def initialize(tag_name, params, tokens)
    super
    @params = params.strip
  end

  def render(context)
    relative_path,  = @params.length > 1 ? parse_parameters(context, @params) : [""]
    post_directory = post_asset(context, relative_path)

    images = super
      .to_s
      .each_line
      .map { |item| item.strip.gsub(/\n/, "") }
      .select { |item| !item.strip.empty? }

    render_html(post_directory, images)
  end


  def render_html(post_directory, images)
    images.map! do |image|
      url = "#{post_directory}/#{image}"
      alt = File.basename(image, File.extname(image)).unicode_normalize(:nfc)
      "<li><figure><img src=\"#{url}\" alt=\"#{alt}\" /></figure></li>"
    end
    "<div class='gallery-block columns-3'>\n<ul>\n#{images.join("\n")}\n</ul>\n</div>"
  end

  Liquid::Template.register_tag("image_gallery", self)
end
