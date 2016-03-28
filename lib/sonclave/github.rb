require 'octokit'
module Sonclave
  class Github

    def initialize(config)
      @config = config
      @client = Octokit::Client.new(:netrc => true)
    end

    def get()
      members = {}
      config = @config.clone
      config.map do |org, org_config |
        members = get_org_teams org
        org_config.each { |name, team| team[:members] = members[name] }
      end
      config
    end

    def get_org_teams(org)
      teams = @client.organization_teams org
      team_members = {} 
      teams.each do |t| 
        team_members[t[:slug]] = (@client.team_members t[:id]).map { |member| member[:login] }
      end
      return team_members
    end

  end
end
