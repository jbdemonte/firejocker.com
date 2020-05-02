require_relative "./plugin_tools"

module PostAsset

  include PluginTools

  # return the post asset path without trailing /
  # last parameter may be a post "context"
  #
  def post_asset(*directories)
    if directories[-1].instance_of?(Jekyll::Drops::DocumentDrop)
      post = directories.pop()
      post_path = post["path"]
    else
      post_path = @context.registers[:page].path
    end
    build_post_asset_url(@context, post_path, directories)
  end

end

Liquid::Template.register_filter(PostAsset)