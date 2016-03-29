require 'yaml'
require 'sonclave/github'
module Sonclave
  class Config

    attr_reader :users, :teams, :github

    def initialize(path = nil)
      path = %W(
        #{path}
        #{ENV['HOME']}/,sonclave
        #{ENV['PWD']}/.sonclave
        /etc/sonclave
        /usr/local/etc/sonclave
      ).find do |dir|
        File.directory?(dir)
      end
      raise "Sonclave config not found. Make a .sonclave!" if not path
      STDERR.puts "Sonclave path is #{path}"
      @path = path
      @users = YAML.load_file "#{path}/users.yml"
      @teams = YAML.load_file "#{path}/github-teams.yml"
      @github = Github.new @teams, github_logins
    end

    def github_logins
      gh = {}
      @users.map do |login, login_config |
          gh[login_config["github"]["login"]] = login
      end
      gh
    end

    def build
      work = {}
      gh_logins = github_logins
      gh_keys = @github.ssh_keys
      @users.each do |login, login_config |
          work[login] = login_config["unix"]
          work[login][:keys] = gh_keys[login]
      end

      teams = @github.teams
      teams.each do |org, teams|
        teams.each do | team_name, team |
          team[:members].each do |github_login|
            login = gh_logins[github_login]
            work[login] = unix_merge(work[login],team["unix"])
          end
        end
      end

      return work
    end

    def unix_merge(left, right)
      right.each do |k,v|
        left[k] = case left[k]
        when NilClass
          v
        when Enumerable
          left[k] + v
        else
          if left[k] != v
            raise "Can't append \"#{v}\" to \"#{left[k]}\" for key \"#{k}\""
          else
            v
          end
        end
      end
      return left
    end
  end
end
