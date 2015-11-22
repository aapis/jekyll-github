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
