module Jekyll
  module Github
    class Repos < Liquid::Tag
      def initialize(name, text, tokens)
        super
      end

      def render(context)
        github = GithubClient.new
        html = []

        user_repos = github.repos
        user_repos.each do |repo|
          html << "<article class=\"gh-repo\">"
            html << "<div class=\"gh-repo-header\">"
              html << "<i class=\"#{repo.language.downcase}\"></i>"
              html << "<h2><a href=\"#{repo.html_url}\" target=\"_blank\">#{repo.name}</a></h2>"
              html << "<p>#{repo.description}</p>"
              html << "<ul>"
                html << "<li>#{repo.watchers_count} watchers and #{repo.stargazers_count} stargazers</li>"

                if repo.open_issues_count == 1
                  html << "<li><a href=\"#{repo.html_url}/issues\">#{repo.open_issues_count} Issue</a></li>"
                elsif repo.open_issues_count > 1
                  html << "<li><a href=\"#{repo.html_url}/issues\">#{repo.open_issues_count} Issues</a></li>"
                end

              html << "</ul>"
            html << "</div>"
          html << "</article>"
        end

        html.join
      end
    end
  end
end
