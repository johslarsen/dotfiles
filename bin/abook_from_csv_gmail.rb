#!/usr/bin/env ruby
require 'csv'

def as_list(cols)
  [cols].flatten.compact.map do |value|
    value.split(" ::: ")
  end.flatten
end

CANONICAL_COUNTRY = Hash.new { |h, k| h[k] = k }.update({
                                                          "Norge" => "Norway"
                                                        })

puts <<~EOF
  # abook addressbook file

  [format]
  program=abook
  version=0.6.1


EOF

CSV.new(ARGF, headers: :first_row).select { |r| r["Name"] }.each_with_index do |r, id|
  next unless r["Name"]

  emails = as_list(1.upto(3).map { |i| r["E-mail #{i} - Value"] }).join(",")
  phones = as_list(1.upto(3).map { |i| r["Phone #{i} - Value"] })
           .map { |p| p.match(/^(\+[0-9]+)[[:space:]]+(.*)$/) { |m| "#{m[1]} #{m[2].gsub(/ /, '')}" } || p }
  address = "#{r['Address 1 - Street']}\n#{r['Address 1 - Extended Address']}"
            .split("\n").map { |a| a.sub(/^([0-9]+) +(.*)/, "\\2 \\1") }
  country = CANONICAL_COUNTRY[r["Address 1 - Country"]]
  groups = as_list(r["Group Membership"])
           .map { |g| g.downcase.gsub(/[* ]/, "") }.reject { |g| g == "mycontacts" }.join(",")

  puts "[#{id}]"
  puts "name=#{r['Name']}"
  puts "email=#{emails}" unless emails.empty?
  puts "mobile=#{phones[0]}" if phones[0]
  puts "phone=#{phones[1]}" if phones[1]
  puts "workphone=#{phones[2]}" if phones[2]
  puts "address=#{address[0]}" if address[0]
  puts "address2=#{address[1]}" if address[1]
  puts "city=#{r['Address 1 - City']}" if r["Address 1 - City"]
  puts "zip=#{r['Address 1 - Postal Code']}" if r["Address 1 - Postal Code"]
  puts "country=#{country}" if country
  puts "anniversary=#{r['Birthday']}" if r["Birthday"]
  puts "groups=#{groups}" unless groups.empty?
  puts
end
