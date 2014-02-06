# -----------------------------------------------
# Sass implementation of the Noisy jquery plugin:
# https://github.com/DanielRapp/Noisy
# by @philippbosch
# https://gist.github.com/1021332
# -----------------------------------------------

module Sass::Script::Functions
  def background_noise(kwargs = {})
    opts = {}
    Sass::Util.map_hash({
        "sigma"      => [0..512,        "",   :Number, Sass::Script::Number.new(5) ],
        "width"      => [1..512,        "px", :Number, Sass::Script::Number.new(200) ],
        "height"     => [1..512,        "px", :Number, Sass::Script::Number.new(200) ],
      }) do |name, (range, units, type, default)|
      
      if val = kwargs.delete(name)
        assert_type val, type, name
        if range && !range.include?(val.value)
          raise ArgumentError.new("$#{name}: Amount #{val} must be between #{range.first}#{units} and #{range.last}#{units}")
        end
      else
        val = default
      end
      opts[name] = val
    end

    size_x = opts["width"].to_i
    size_y = opts["height"].to_i

    image = ChunkyPNG::Image.new(size_x, size_y)

    mean = 0    # always set to zero for gamma-neutral output.
    sdev = opts["sigma"].to_s.to_f

    gen = Rubystats::NormalDistribution.new(mean, sdev)

    for x in (0..size_x)
      for y in (0..size_y)

        n = gen.rng()

        if n < -255 or n > 255
          value=255
        else
          value=n.abs
        end

        value=value.floor

        if n < 0  # black
          color=ChunkyPNG::Color.rgba(0,0,0, value)
        else      # white
          color=ChunkyPNG::Color.rgba(255,255,255, value)
        end

        image.set_pixel(x, y, color)

      end
    end

#    for i in (0..(opts["intensity"].to_s.to_f * (opts["size"].to_i**2)))
#       x = rand(opts["size"].to_i)
#       y = rand(opts["size"].to_i)
#       r = rand(255)
#       a = rand(255 * opts["opacity"].to_s.to_f)
#       color = opts["monochrome"] ? ChunkyPNG::Color.rgba(r, r, r, a) : ChunkyPNG::Color.rgba(r, rand(255), rand(255), a)
#       image.set_pixel(x, y, color)
#    end
    
    data = Base64.encode64(image.to_blob).gsub("\n", "")
    Sass::Script::String.new("url('data:image/png;base64,#{data}')")
  end
  declare :background_noise, [], :var_kwargs => true
end
