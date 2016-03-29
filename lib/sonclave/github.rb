require 'octokit'
module Sonclave
  class Github

    def initialize(team_config, user_config)
      @team_config = team_config
      @user_config = user_config
      @client = Octokit::Client.new(:netrc => true)
    end

    def teams()
      return @teams if @teams
      members = {}
      config = @team_config.clone
      config.map do |org, org_config |
        members = org_teams org
        org_config.each { |name, team| team[:members] = members[name] }
      end
      @teams = config
    end

    def ssh_keys
      return @ssh_keys if @ssh_keys
      result = {}
      @user_config.each do |gh_login, unix_login|
        result[unix_login] = @client.user_keys(gh_login).map { |k| k.key }
      end
      @ssh_keys = result
    end

    def org_teams(org)
      teams = @client.organization_teams org
      team_members = {} 
      teams.each do |t| 
        team_members[t[:slug]] = (@client.team_members t[:id]).map { |member| member[:login] }
      end
      return team_members
    end

  end
end
