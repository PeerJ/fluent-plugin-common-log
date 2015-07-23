# fluent-plugin-common-log
Fluent TextFormatter Plugin for the common log format

Sample (using simplier apache2 format, records as http version 1.1)
```
<source>
  format apache2
</source>

<match *>
  type file
  path /var/log/common_log_example.log
  format common_log
  fields "{:host => 'host', :user => 'user', :method => 'method', :path => 'path', :code => 'code', :size => 'size', :referer => 'referer', :agent => 'agent' }"
</match>
```

Sample (using custom format, but sets correct http version in logs)
```
<source>
  format /^(?<host>[^ ]*) [^ ]* (?<user>[^ ]*) \[(?<time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>[^ ]*) +(?<version>[^\"]*))?" (?<code>[^ ]*) (?<size>[^ ]*)(?: "(?<referer>[^\"]*)" "(?<agent>[^\"]*)")?$/
  time_format %d/%b/%Y:%H:%M:%S %z
</source>

<match *>
  type file
  path /var/log/common_log_example.log
  format common_log
  fields "{:host => 'host', :user => 'user', :method => 'method', :path => 'path', :code => 'code', :size => 'size', :referer => 'referer', :agent => 'agent', :version => 'version' }"
</match>

```
