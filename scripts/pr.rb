#!/usr/bin/ruby

# https://stackoverflow.com/a/16363159/4088882
class String
  def blue;           "\e[34m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def bold;           "\e[1m#{self}\e[22m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end

def checkout(pull_number)
  exec("gh pr checkout #{pull_number}")
end

def pretty_pull(pull, search_exp, current_branch)
  branch_section = current_branch == pull[:branch] ? "[#{pull[:branch]} (HEAD)]".green.bold : "[#{pull[:branch]}]".green
  "#{('#' + pull[:number]).blue} #{branch_section} #{pull[:title].gsub(search_exp, '\0'.underline.red)}"
end

current_branch = `git branch --show-current`.chomp

pulls = `gh pr status`.split("\n").select { |e| e.match?(/#\d+/) }.map do |pull_line|
  result = {}
  pull_line.match(/#(\d+)\s+(.*)\s\[([\w\/]+)\]$/) do |match|
    result[:number] = match[1]
    result[:title] = match[2]
    result[:branch] = match[3]
  end
  result
end

pulls.reject! { |pull| pull == {} || pulls.map{ |e| e[:number] }.count(pull[:number]) > 1 }

unless ARGV.first
  puts('No search pattern provided.')
  return
end

search_exp = Regexp.new(ARGV.first, Regexp::IGNORECASE)
matches = pulls.filter { |pull| pull[:title].match?(search_exp) }

if matches.count == 0
  puts("No pull-requests match: #{ARGV.first.red}")
  return
end

# if matches.count > 1
  matches.each_with_index do |pull, i|
    puts("#{"#{i+1})".bold} #{pretty_pull(pull, search_exp, current_branch)}")
  end
  print("Input the number of the pull-request you wish to check out: (1-#{matches.count}): ")
  response = $stdin.gets("\n")&.chomp
  return unless response

  num = response.to_i
  checkout(matches[num - 1][:number]) if num > 0
# else
#   # TODO: Consider just always showing the list, even if one entry.
#   pull = matches.first
#   puts(pretty_pull(pull, search_exp, current_branch))
#   print('Do you want to check out the pull-request? (Y/n): ')
#   response = $stdin.gets("\n")&.chomp
#   return unless response
# 
#   checkout(pull[:number]) if response == '' || response.casecmp?('y')
# end
