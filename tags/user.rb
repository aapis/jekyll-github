module Jekyll
  module Github
    class User < Liquid::Tag
      def initialize(name, text, tokens)
        super
      end

      def render(context)
        github = GithubClient.new
        user = github.user
        html = []

        html << "<section class=\"gh-user\">"
          html << "<h2><a href=\"#{user.html_url}\">#{user.login}</a></h2>"
          html << "<ul>"
            html << "<li class=\"company\">Works for #{user.company}</a></li>" if user.company
            html << "<li class=\"location\">Lives in #{user.location}</a></li>" if user.location
            html << "<li class=\"counts\">#{user.public_repos || 0} public repositories and #{user.public_gists || 0} public gists</a></li>"
          html << "</ul>"
        html << "</section>"
      end
    end
  end
end
