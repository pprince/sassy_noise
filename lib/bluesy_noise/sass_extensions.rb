# -----------------------------------------------
# Sass implementation of the Noisy jquery plugin:
# https://github.com/DanielRapp/Noisy
# by @philippbosch
# https://gist.github.com/1021332
# -----------------------------------------------

module Sass::Script::Functions
  def gnoise(kwargs = {})
    opts = {}
    Sass::Util.map_hash({
        "width"      => [1..512,        "px", :Number, Sass::Script::Number.new(100) ],
        "height"     => [1..512,        "px", :Number, Sass::Script::Number.new(100) ],
        "sigma"      => [0..512,        "",   :Number, Sass::Script::Number.new(5) ],
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

    data = Base64.encode64(image.to_blob).gsub("\n", "")
    Sass::Script::String.new("url('data:image/png;base64,#{data}')")
  end
  declare :gnoise, [], :var_kwargs => true
end
