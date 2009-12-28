require 'fileutils'

config = File.dirname(__FILE__) + '/../../../config/site_config.yml'
FileUtils.cp File.dirname(__FILE__) + '/site_config.yml.tpl', config unless File.exist?(config)
puts IO.read(File.join(File.dirname(__FILE__), 'README'))