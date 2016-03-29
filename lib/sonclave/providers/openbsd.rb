require "shellwords"
module Sonclave
  module Providers
    class OpenBSD
      attr_writer :key_path
      def go(logins)
        cmds = logins.map do |login, values|
          opts = {
            'groups' => '-S', # should be -G for useradd
            'shell' => '-s',
            'class' => '-L',
            'comment' => '-c',
          }

          keys = values.delete :keys

          args = values.map do |k,v|
            v = v.join ',' if v.is_a? Array
          [opts[k],v]
          end .flatten
          ([
            ["usermod", "-v", args, login],
            ["useradd", "-v", "-m", args.map {|x| x.sub(/^-S$/, '-G') }, login ]
          ].map { |a| Shellwords.join a.flatten } .join ' || ') + 
          ("&& \n" + Shellwords.join(["echo", keys.join("\n") ]) + " > " + Shellwords.escape("#{@key_path}/#{login}") )
        end
        cmds.unshift "set -f"
        cmds.unshift "set -x"
        cmds.unshift "set +o noclobber"
        cmds.unshift "mkdir -p #{@key_path}"
      end
    end
  end
end
