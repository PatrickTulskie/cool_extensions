$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

Dir.glob(File.expand_path(File.dirname(__FILE__))+'/cool_extensions/*').each do |search|
  require search
end

module CoolExtensions
  VERSION = '0.0.1'
end



