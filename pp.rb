# -*- coding: utf-8 -*-
require 'json'

def json_pp(json_data)
  puts "==== PP ===="
  puts JSON.pretty_generate(JSON.parse(json_data))
end





