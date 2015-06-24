module Fluent
  module TextFormatter
    class CommonLogFormatter < Formatter
      # Register CommonLogFormatter as "common_log".
      Plugin.register_formatter("common_log", self)

      include HandleTagAndTimeMixin # If you wish to use tag_key, time_key, etc.
      # fields are: host, user, time, method, path, code, size, referrer, agent
      config_param :fields, :string

      # This method does further processing. Configuration parameters can be
      # accessed either via "conf" hash or member variables.
      def configure(conf)
        super
        @fields = eval(conf['fields'])
        $log.error @fields
      end

      def dashIfEmpty(value)
        if !value
          value = "-"
        end

        value
      end

      # This is the method that formats the data output.
      def format(tag, time, record)
        values = []

        values << dashIfEmpty(record[@fields[:host]])
        values << "-"
        values << dashIfEmpty(record[@fields[:user]])
        values << sprintf('[%s]', Time.at(time).strftime("%d/%b/%Y:%H:%M:%S %z"))
        values << sprintf('"%s %s HTTP/1.1"', record[@fields[:method]], record[@fields[:path]])
        values << record[@fields[:code]]
        values << record[@fields[:size]]
        values << sprintf('"%s"', dashIfEmpty(record[@fields[:referer]]))
        values << sprintf('"%s"', dashIfEmpty(record[@fields[:agent]]))

        # Output by joining the fields with a space
        sprintf("%s\n", values.join(" "))
      end
    end        
  end
end

