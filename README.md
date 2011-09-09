Sassy noise
===========

A Sass port of Noisy JS (https://github.com/DanielRapp/Noisy) for generating
noise background images as base64 data URIs.

Based on work of @philippbosch & @aaronrussell (https://gist.github.com/1200394/741bb7566da29b1e1550f3e7e135390966f5c83f).

Installation
============

    $ gem install sassy_noise
    
In your Compass projects config.rb etc:

    require "sassy_noise"

Basic usage
===========


    
In your .scss:

    // Default values
    // $bg-noise-intensity-default:  0.5;
    // $bg-noise-opacity-default:    0.08;
    // $bg-noise-size-default:       200;
    // $bg-noise-mono-default:       false;

    @import "sassy_noise";
    
    // Example usage on <body>
    
    body {
      @include sassy_noise;
    }
    
    // Monochrome example
    body {
      @include sassy_noise($mono: true);
    }
    
No templates?
=============

I've omitted the project template because probably no-one wants to build a
project based on noise. I might add another pattern later.

