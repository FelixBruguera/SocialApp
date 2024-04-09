module PostsHelper
    require "image_processing/mini_magick"

    def resize_before_save(image_param, width, height)
        return unless image_param
        image = ImageProcessing::MiniMagick
        .source(image_param)
        .resize_to_fit(width, height)
        .call
    end

    def post_id(query)
      Post.find_by(slug: query).id
    end
end
