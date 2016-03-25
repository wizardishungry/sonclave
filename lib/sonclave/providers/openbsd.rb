require "shellwords"
module Sonclave
  module Providers
    class OpenBSD 
      def self.go(logins)
        cmds = logins.map do |login, values|
          opts = {
            'groups' => '-S', # should be -G for useradd
            'shell' => '-s',
            'class' => '-L',
            'comment' => '-c',
          }
          args = values.map do |k,v|
            v = v.join ',' if v.is_a? Array
            [opts[k],v]
          end .flatten 
          [
            ["usermod", "-v", args, login],
            ["useradd", "-v", "-m", args.map {|x| x.sub(/^-S$/, '-G') }, login ]
          ].map { |a| Shellwords.join a.flatten } .join ' || '
        end
        cmds.unshift "set -f"
        cmds.unshift "set -x"
      end
    end
  end
end
