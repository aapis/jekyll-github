class Github
  attr_reader :client, :endpoint, :repo_location

  def initialize(user_repo = nil)
    # authenticate the user
    begin
      @client = Octokit::Client.new(:login => $config.get[:github_user], :password => $config.get[:github_pass])
      #@repo_location = user_repo
    rescue => e
      ::Notify.error(e.message)
    end
  end

  def pulls_in_timeframe(date_start = nil, date_end = nil)
    @client.auto_paginate = true
    list = @client.pull_requests(@repo_location,
      :state => :closed,
      :per_page => 500,
      :sort => 'long-running'
      )

    pr_format_str = "%s (%s)\n - Created by %s\n - Branch: %s\n - Merged by %s on %s\n - Changes: %s\n\n"
    prs_covered = 0
    log = Log.new
    
    File.open(log.path, 'w+') do |f|
      list.each do |pr|
        if (date_start..date_end).cover? pr.merged_at
          # increment the number of PRs covered by the requested date range
          prs_covered += 1

          f.write(
            sprintf(
            pr_format_str,
            pr.title,
            pr.html_url,
            pr.user.login,
            pr.head.ref,
            user_who_merged(pr.number),
            Time.formatted(pr.merged_at, true),
            pr.diff_url
            )
          )
        end
      end

      f.write("============================================================\n#{prs_covered} PR(s) merged from #{date_start} to #{date_end}\n============================================================\n")
    end
    
    if prs_covered == 0
      ::Notify.warning("No pull requests have been merged in the requested date range (#{date_start} - #{date_end})")
      ::Notify.bubble("No PRs in that range", "Github - Error")
    else
      ::Notify.bubble("Request returned results, see log file for details", "Github - Success")
      # workaround required for this message to print when piping data to other commands
      # i.e. granify github merged_today | evertils new share_note --title="testing share"
      if STDOUT.tty?
        ::Notify.success("Logged to #{log.path}")
        c = Command::Exec.new
        c.open_editor
      end
    end
    
    # enable pipe support
    if !STDOUT.tty?
      puts log.contents.to_s
    end
  end
  
  def search_pulls_by(value, field = :title)
    list = @client.pull_requests(@repo_location,
      :state => :all,
      :per_page => 100
      )
    pr_format_str = "%s (%s)\n - Created by %s\n - Branch: %s\n - Changes: %s\n\n"
    prs_covered = 0
    log = Log.new

    File.open(log.path, 'w+') do |f|
      list.each do |pr|
        if Utils.nested_hash_value(pr, field).match(/#{value}\b/)
          # increment the number of PRs covered by the requested date range
          prs_covered += 1

          f.write(
            sprintf(
            pr_format_str,
            pr.title,
            pr.html_url,
            pr.user.login,
            pr.head.ref,
            pr.diff_url
            )
          )
        end
      end

      f.write("============================================================\n#{prs_covered} PR(s) matched\n============================================================\n")
    end

    if prs_covered == 0
      ::Notify.warning("No pull requests match the requested term (#{value})")
      ::Notify.bubble("No PRs matched #{value}", "Github - Error")
    else
      ::Notify.bubble("Request returned results, see log file for details", "Github - Success")
      
      if STDOUT.tty?
        ::Notify.success("Logged to #{log.path}")
        c = Command::Exec.new
        c.open_editor
      end
    end
  end

  private
    def user_who_merged(pr_number)
      pr = @client.pull_request(@repo_location, pr_number)
      pr.merged_by.login
    end
end