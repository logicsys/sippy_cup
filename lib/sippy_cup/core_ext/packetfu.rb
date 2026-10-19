# encoding: utf-8
require 'packetfu'

# packetfu 2.0.0 (latest release) finds the setter that called StructFu#typecast
# by matching caller[0] against /`([^']+)='/. Ruby 3.4 changed backtrace labels
# from `meth' to 'Klass#meth', so the match returns nil and every setter raises
# NoMethodError. Look the setter name up via caller_locations instead, which is
# stable across Ruby versions.
module StructFu
  def typecast(i)
    c = caller_locations(1, 1).first.base_label.chomp('=')
    self[c.to_sym].read i
  end
end
