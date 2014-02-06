require 'compass'
require 'chunky_png'
require 'base64'
require 'rubystats'

require File.join(File.dirname(__FILE__), 'bluesy-noise', 'sass_extensions')

extension_path = File.expand_path(File.join(File.dirname(__FILE__), ".."))
Compass::Frameworks.register('bluesy-noise', :path => extension_path)
