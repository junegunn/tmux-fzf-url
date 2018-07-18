#!/usr/bin/env ruby
# frozen_string_literal: true

# Ruby port of fzf-url.sh

require 'shellwords'

def with_filter(command)
  io = IO.popen(command, 'r+')
  begin
    stdout = $stdout
    $stdout = io
    begin
      yield
    rescue Errno::EPIPE
      nil
    end
  ensure
    $stdout = stdout
  end
  io.close_write
  io.readlines.map(&:chomp)
end

# TODO: Keep it simple for now
def extract_urls(line)
  line.scan(%r{(?:https?|file)://[-a-zA-Z0-9@:%_+.~#?&/=]+}x)
end

lines = `tmux capture-pane -J -p -S -99999`
urls = lines.each_line.map(&:strip).reject(&:empty?)
            .flat_map { |l| extract_urls(l) }.reverse.uniq

if urls.empty?
  system 'tmux display-message "No URLs found"'
  exit
end

selected = with_filter('fzf-tmux -d 35% -m -0 -1') { puts urls }
opener = if !`command -v open`.empty?
           'open'
         elsif !`command -v xdg-open`.empty?
           'xdg-open'
         else
           'echo'
         end

selected.each do |url|
  system "#{opener} #{Shellwords.escape url}"
end
