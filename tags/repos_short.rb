module Jekyll
  module Github
    class Repos_short < Liquid::Tag
      def initialize(name, text, tokens)
        super
      end

      def render(context)
        github = ::GithubClient.new(limit: 5)
        html = []

        user_repos = github.repos_short

        html << "<ul>"
        user_repos.each do |repo|
          html << "<li><a href=\"#{repo.html_url}\" target=\"_blank\">#{repo.name}</a> - #{repo.description}</li>"
        end
        html << "</ul>"

        html.join
      end
    end
  end
end