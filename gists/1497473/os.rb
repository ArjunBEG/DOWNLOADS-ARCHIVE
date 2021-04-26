require 'rbconfig'
host_os = RbConfig::CONFIG['host_os']

if host_os ~= /mac|darwin/i
  # Mac
elsif host_os ~= /bsd/i
  # BSD
elsif host_os ~= /solaris|sunos/i
  # Solaris
elsif host_os ~= /linux/i
  # Linux
elsif host_os ~= /mswin|windows|cygwin/i
  # Windows
else
  # Any platform