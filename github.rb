require 'octokit'
require 'notifaction'

class GithubClient
  attr_reader :client, :endpoint, :repo_location

  def initialize(options = {})
    # authenticate the user
    begin
      @client = Octokit::Client.new(:login => ENV['GITHUB_TOKEN_USER'], :password => ENV['GITHUB_TOKEN_PASS'])
      @options = options
    rescue => e
      ::Notify.error(e.message)
    end
  end

  def repos
    @client.repositories(@client.login, visibility: :public, sort: :updated)
  end

  def repos_short
    repos.take(@options[:limit] || 5)
  end

  def user
    @client.user(@client.login)
  end

  def public_contributions
    x = @client.user_public_events(@client.login, limit: 300)
    x.each do |event|
      puts event[:type]
    end
  end
end