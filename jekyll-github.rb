require_relative './github'

module Jekyll
  module Github
    class Repos < Liquid::Tag
      def initialize(name, text, tokens)
        super
      end

      def render(context)
        github = ::GithubClient.new
        html = []

        user_repos = github.repos

        user_repos.each do |repo|
          html << "<article class=\"blog-post\">"
            html << "<div class=\"blog-post-header\">"
              html << "<i class=\"#{repo.language.downcase}\"></i>"
              html << "<h2><a href=\"#{repo.html_url}\" target=\"_blank\">#{repo.name}</a></h2>"
              html << "<p>#{repo.description}</p>"
            html << "</div>"
          html << "</article>"
        end

        html.join
      end
    end
  end
end

Liquid::Template.register_tag('github_repos', Jekyll::Github::Repos)

module Jekyll
  module Github
    class User < Liquid::Tag
      def initialize(name, text, tokens)
        super
      end

      def render(context)
        github = ::GithubClient.new
        html = []

        github.user
      end
    end
  end
end

Liquid::Template.register_tag('github_user', Jekyll::Github::User)