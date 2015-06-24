# fluent-plugin-common-log
Fluent TextFormatter Plugin for the common log format

Sample
```
<match *>
  type file
  path /var/log/common_log_example.log
  format common_log
  fields "{:host => 'host', :user => 'user', :method => 'method', :path => 'path', :code => 'code', :size => 'size', :referer => 'referer', :agent => 'agent' }"
</match>
```
