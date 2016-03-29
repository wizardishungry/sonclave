require "awesome_print"
require 'sonclave/config'
require 'sonclave/providers/openbsd'
module Sonclave
  class Command

    def initialize(args)
      @config = Config.new 
      @args = args
    end

    def run_command!(command)
      begin
        send("do_#{command}", *@args)
      rescue ArgumentError
        do_help()
      end
    end

    def do_help()
      STDERR.puts %{
#{$PROGRAM_NAME} <verb>

Valid verbs are:
  go\t output commands 
  dump [all|teams|gh-teams|gh-logins|gh-keys|users]\t dump an internal structure
}
      exit 1
    end

    def do_go()
      unix = Sonclave::Providers::OpenBSD.new
      unix.key_path = "/etc/ssh/authorized_keys" # FIXME read from config
      puts unix.go build
    end

    def do_dump(scope="all")
      ap case scope 
        when "all" then build
        when "teams" then @config.teams
        when "gh-teams" then @config.github.teams
        when "gh-logins" then @config.github_logins
        when "gh-keys" then @config.github.ssh_keys
        when "users" then @config.users
        else raise ArgumentError
      end, :index => false
    end

    def build
      @config.build
    end

  end
end
