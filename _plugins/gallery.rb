# Coded by a Ruby / Jekyll / Liquid totally noob in mode "wtf... why ruby? why like this??"
# Don't shame on me

module Jekyll
  class ImageGalleryBlock < Liquid::Block

    def initialize(tag_name, relative_path, tokens)
      super
      @relative_path = relative_path.empty? ? "" : relative_path.strip.to_s.chomp("/")
    end

    def render(context)
      @context = context
      site = context.registers[:site]
      page = context.registers[:page]

      baseurl = site.config["baseurl"].to_s.chomp("/")
      post_directory = page.path.to_s.sub('_posts/', '').chomp(".md")
      relative_path = parse_assets_path(context)
      if !relative_path.empty?
        post_directory = post_directory + "/" + relative_path
      end

      full_path = "#{baseurl}/assets/posts/#{post_directory}"

      images = super.to_s
        .gsub("'", "&apos;") # html entity '
        .each_line
        .map {|item| item.strip.gsub(/\n/, "")}
        .select do |item| # remove empty lines
          !item.strip.empty?
        end

      result =  "<div class='gallery-block columns-3'>\n<ul>"
      images.each do |image|
        url = "#{full_path}/#{image}".gsub("'", %q(\\\'))
        alt = File.basename(image, File.extname(image)).unicode_normalize(:nfc)
        result += "<li><figure><img src='#{url}' alt='#{alt}' /></figure></li>"
      end
      result += "</ul>\n</div>"
    end

    # Based on https://github.com/samrayner/jekyll-asset-path-plugin/blob/master/asset_path_tag.rb
    def parse_assets_path(context)
      parameters = Liquid::Template.parse(@relative_path).render context
      parameters.strip!

      filename = parameters[0] ||  ""
      if ['"', "'"].include? parameters[0]
        last_quote_index = parameters.rindex(parameters[0])
        filename = parameters[1...last_quote_index]
      end

      # html entities for '
      filename.gsub("'", "&apos;")
    end
  end
end

Liquid::Template.register_tag('image_gallery', Jekyll::ImageGalleryBlock)
