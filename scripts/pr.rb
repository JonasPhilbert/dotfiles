#!/usr/bin/ruby

pulls = `gh pr status`.split("\n").select { |e| e.match?(/#\d+/) }.map do |pull_line|
  result = {}
  pull_line.match(/#(\d+)\s+(.*)\s\[([\w\/]+)\]$/) do |match|
    result[:number] = match[1]
    result[:title] = match[2]
    result[:branch] = match[3]
  end
  result
end
