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
              html << "<h2><i class=\"devicon-#{repo.language.downcase}-plain colored\"></i> <a href=\"#{repo.html_url}\" target=\"_blank\">#{repo.name}</a></h2>"
              html << "<p>#{repo.description}</p>"
              html << "<ul>"
                html << "<li>#{repo.watchers_count} watcher(s) and #{repo.stargazers_count} stargazer(s)</li>"

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
