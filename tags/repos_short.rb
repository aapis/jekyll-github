module Jekyll
  module Github
    class Repos_short < Liquid::Tag
      def initialize(name, text, tokens)
        super
      end

      def render(context)
        github = GithubClient.new(limit: 4)
        html = []
        user_repos = github.repos_short

        html << "<ul class=\"gh-short-repo\">"
        user_repos.each do |repo|
          lang = if repo.language.nil? then 'github' else repo.language.downcase end

          html << "<li><i class=\"devicon-#{lang}-plain colored\"></i> <a href=\"#{repo.html_url}\" target=\"_blank\">#{repo.name}</a> - #{repo.description}</li>"
        end
        html << "</ul>"

        html.join
      end
    end
  end
end
