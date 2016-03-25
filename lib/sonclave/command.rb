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
      STDERR.puts "use 'go'"
      exit 1
    end

    def do_go()
      unix_work = Hash.new
      @config.users.each do |login, login_config |
          unix_work[login] = login_config["unix"]
      end
      puts Sonclave::Providers::OpenBSD.go unix_work
    end
  end
end
