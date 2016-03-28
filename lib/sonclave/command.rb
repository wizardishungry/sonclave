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
  dump [all|teams|gh-teams|users]\t dump an internal structure
}
      exit 1
    end

    def do_go()
      puts Sonclave::Providers::OpenBSD.go build
    end

    def do_dump(scope="all")
      ap case scope 
        when "all" then build
        when "teams" then @config.teams
        when "gh-teams" then @config.github.get
        when "users" then @config.users
        else raise ArgumentError
      end, :index => false
    end

    def build
      @config.build
    end

  end
end
