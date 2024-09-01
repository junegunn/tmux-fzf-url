#!/usr/bin/env ruby
# frozen_string_literal: true

require 'English'
require 'shellwords'

def executable(*commands)
  commands.find do |c|
    `command -v #{c.split.first}`.empty?.!
  end
end

def halt(message)
  system "tmux display-message #{Shellwords.escape(message)}"
  exit
end

def with(command)
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
  line.scan(%r{(?:https?|file)://[-a-zA-Z0-9@:%_+.~#?&/=]+[-a-zA-Z0-9@%_+.~#?&/=!]+}x)
end

lines = `tmux capture-pane -J -p -S -99999`
urls = lines.each_line.map(&:strip).reject(&:empty?)
            .flat_map { |l| extract_urls(l) }.reverse.uniq
halt 'No URLs found' if urls.empty?

header = 'Press CTRL-Y to copy URL to clipboard'
max_size = `tmux display-message -p "\#{client_width} \#{client_height}"`.split.map(&:to_i)
size = [[*urls, header].map(&:length).max + 7, urls.length + 5].zip(max_size).map(&:min).join(',')
opts = ['--tmux', size, '--multi', '--no-margin', '--no-padding', '--wrap',
        '--expect', 'ctrl-y',
        '--header', header,
        '--highlight-line', '--header-first', '--info', 'inline-right',
        '--border-label', ' URLs '].map(&:shellescape).join(' ')
selected = with("fzf #{opts}") do
  puts urls
end
exit if selected.length < 2

if selected.first == 'ctrl-y'
  # https://superuser.com/questions/288320/whats-like-osxs-pbcopy-for-linux
  copier = executable('reattach-to-user-namespace pbcopy',
                      'pbcopy',
                      'xsel --clipboard --input',
                      'xclip -selection clipboard')
  halt 'No command to control clipboard with' unless copier
  with(copier) do
    print selected.drop(1).join($RS).strip
  end
  halt 'Copied to clipboard'
end

opener = executable('open', 'xdg-open')
opener = 'nohup xdg-open' if opener == 'xdg-open'
halt 'No command to open URL with' unless opener
selected.drop(1).each do |url|
  system "#{opener} #{Shellwords.escape(url)} &> /dev/null"
end
