require_relative './github'

module Jekyll
  class GithubRepos < Liquid::Tag
    def initialize(name, text, tokens)
      super
    end

    def render(context)
      github = Github.new('aapis')
      "test 2"
    end
  end
end

Liquid::Template.register_tag('github', Jekyll::GithubRepos)