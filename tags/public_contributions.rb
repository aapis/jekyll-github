module Jekyll
  module Github
    class Public_contributions < Liquid::Tag
      def initialize(name, text, tokens)
        super
        puts "WARNING - public_contributions is currently in development"
      end

      def render(context)
        github = GithubClient.new(limit: 4)
        html = []
        user_repos = github.public_contributions

        html << "<ul class=\"gh-short-repo\">"
        user_repos.each do |repo|
          lang = if repo.language.nil? then 'github' else repo.language.downcase end

          html << "<li><i class=\"devicon-#{lang}-plain colored\"></i> <a href=\"#{repo.html_url}\" target=\"_blank\">#{repo.name}</a> - #{repo.description.gsub(/<\/?[^>]*>/, "")}</li>"
        end
        html << "</ul>"

        html.join
      end
    end
  end
end
