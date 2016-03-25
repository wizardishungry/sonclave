require 'yaml'
module Sonclave
  class Config
    attr_reader :users
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
    end
  end
end
