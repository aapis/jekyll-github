require_relative './github'

# load each tag class
Dir['./_plugins/jekyll-github/tags/*'].each do |file|
  require file
end

# register each tag with Liquid
tag_classes = Jekyll::Github.constants.select {|c| Jekyll::Github.const_get(c).is_a? Class}

tag_classes.each do |klass|
  Liquid::Template.register_tag(klass.downcase, Jekyll::Github.const_get(klass))
end
