require 'octokit'
require 'notifaction'

class GithubClient
  attr_reader :client, :endpoint, :repo_location

  def initialize(user_repo = nil)
    # authenticate the user
    begin
      @client = Octokit::Client.new(:login => ENV['GITHUB_TOKEN_USER'], :password => ENV['GITHUB_TOKEN_PASS'])
      #@repo_location = user_repo
    rescue => e
      ::Notify.error(e.message)
    end
  end

  def repos
    @client.repositories(@client.login, { type: :public })
  end

  def user
    @client.login
  end
end