require_relative './github'

module Jekyll
  class GithubRepos < Liquid::Tag
    def initialize(name, text, tokens)
      super
    end

    def render(context)
      github = Github.new
      html = []

      user_repos = github.repos

      user_repos.each do |repo|
        html << "<article class=\"blog-post\">"
          html << "<div class=\"blog-post-header\">"
            html << "<i class=\"#{repo.language.downcase}\"></i>"
            html << "<h2><a href=\"#{repo.html_url}\" target=\"_blank\">#{repo.full_name}</a></h2>"
            html << "<p>#{repo.description}</p>"
          html << "</div>"
        html << "</article>"
      end

      html.join
    end
  end
end

Liquid::Template.register_tag('github', Jekyll::GithubRepos)